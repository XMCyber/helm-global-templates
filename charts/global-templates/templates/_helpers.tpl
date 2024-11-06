{{/*
Copyright (C) 2024 XM Cyber
Author: Devops Infra Team
*/}}

{{/*
  Render an array of env variables. The input can be a map or a slice.
  Usage: 
    {{- include "helpers.toEnvArray" (dict "container" . "global" $global_values "context" $) }}
*/}}
{{- define "helpers.toEnvArray" -}}
{{- $envArray := list -}}
{{- $global := .global -}}

{{- if kindIs "map" .container.env }}
  {{- range $key, $value := .container.env }}
    {{- $envArray = append $envArray (dict "name" $key "value" $value) -}}
  {{- end }}
{{- else if kindIs "slice" .container.env }}
  {{- range .container.env }}
    {{- $envArray = append $envArray (dict "name" .name "value" .value) -}}
  {{- end }}
{{- end }}

{{- range $envArray }}
{{- $renderedValue := include "helpers.renderGlobalIfExists" (dict "value" .value "global" $global) }}
- name: {{ .name }}
  value: {{ $renderedValue }}
{{- end }}
{{- end }}

{{/*
  Render the image full path
  Usage: 
    {{ include "helpers.image.fullPath" (dict "container" . "global" $global_values) }}
*/}}
{{- define "helpers.image.fullPath" -}}

{{- $images := dict -}}
{{- $registry := "" -}}
{{- $container := .container -}}

{{- if .global -}}
  {{- $images = .global.images -}}
  {{- $registry = .global.registry -}}
{{- end -}}

{{- $image := dict -}}

{{- if $container.image }}
  {{- if not $container.image.repository }}
    {{- fail "Image repository must be provided" -}}
  {{- end -}}
  {{- $_ := set $image "registry" ($container.image.registry | default $registry) -}}
  {{- $_ := set $image "repository" $container.image.repository -}}
  {{- $_ := set $image "tag" (or $container.image.tag "") -}}
  {{- $_ := set $image "sha" (or $container.image.sha "") -}}
{{- else if $container.imageKey }}
  {{- $imgConf := get $images $container.imageKey -}}
  {{- if not $imgConf }}
    {{- fail (printf "Image with key '%s' not found" $container.imageKey $images) -}}
  {{- end -}}
  {{- if not $imgConf.repository }}
    {{- fail (printf "Image repository must be provided for key '%s'" $container.imageKey) -}}
  {{- end -}}
  {{- $_ := set $image "registry" $registry -}}
  {{- $_ := set $image "repository" $imgConf.repository -}}
  {{- $_ := set $image "tag" (or $imgConf.tag "") -}}
  {{- $_ := set $image "sha" (or $imgConf.sha "") -}}
{{- else }}
  {{- fail "Either image or imageKey must be provided for the container" -}}
{{- end -}}


{{- if and (not $image.tag) (not $image.sha) }}
  {{- fail "Either tag or sha must be provided" -}}
{{- end -}}

{{- if $image.sha }}
  {{- printf "%s/%s@%s" $image.registry $image.repository $image.sha -}}
{{- else }}
  {{- printf "%s/%s:%s" $image.registry $image.repository $image.tag -}}
{{- end -}}
{{- end -}}

{{/*
  Copy an array
  Usage: 
    {{ include "helpers.copyArray" . }}
*/}}
{{- define "helpers.copyArray" -}}
[{{ range $index, $element := . }}{{ if $index }},{{ end }}"{{ $element }}"{{ end }}]
{{- end -}}

{{/* 
  Helper function to determine the namespace
  Usage: 
    {{ include "helpers.namespace" . }}
*/}}
{{- define "helpers.namespace" -}}
{{- $ns := .ns | default "default" }}
{{- $overrideNs := .overrideNs -}}
{{- if and $overrideNs (ne $overrideNs "default") }}
{{- $overrideNs }}
{{- else }}
{{- $ns }}
{{- end }}
{{- end -}}

{{/*
  Render the metadata lables
  Usage:
  {{ include "helpers.labels" (dict "context" $ "customLabels" .labels "defaultLabels" $common_defaults.labels) }}
*/}}
{{- define "helpers.labels" -}}
{{- $standardLabels := (include "common.labels.standard" .context | fromYaml) }}
{{- $customLabels := .customLabels | default dict }}
{{- $defaultLabels := .defaultLabels | default dict }}
{{- $combinedLabels := merge $standardLabels $customLabels $defaultLabels }}
{{- include "common.tplvalues.render" (dict "value" $combinedLabels "context" .context) }}
{{- end }}

{{/*
  Render the metadata annotation
  Usage:
    {{ include "helpers.annotations" (dict "context" $ "customAnnotations" .annotations "defaultAnnotations" $common_defaults.annotations "reloaderEnabled" .reloaderEnabled) }}
*/}}
{{- define "helpers.annotations" -}}
{{- $customAnnotations := .customAnnotations | default dict }}
{{- $defaultAnnotations := .defaultAnnotations | default dict }}
{{- $combinedAnnotations := merge $defaultAnnotations $customAnnotations }}
{{- if .reloaderEnabled }}
{{- $combinedAnnotations := merge $combinedAnnotations (dict "reloader.stakater.com/auto" "true") }}
{{- end }}
{{- include "common.tplvalues.render" (dict "value" $combinedAnnotations "context" .context) }}
{{- end }}

{{/*
  Validate an enum value
  Usage:
    {{ include "helpers.validateEnumValue" (list .value (list "Option1" "Option2" "Option3")) }}
*/}}
{{- define "helpers.validateEnumValue" -}}
{{- $value := index . 0 }}
{{- $list := index . 1 }}
{{- if not (has $value $list) }}
{{ fail (printf "Invalid value: %s. Must be one of: %s" $value (join ", " $list)) }}
{{- end }}
{{- end }}

{{/*
  Prefix a single namespace
  Usage:
    {{ include "helpers.prefixNamespace" (dict "namespace" "my-namespace" "global" $global_values) }}
*/}}
{{- define "helpers.prefixNamespace" -}}
{{- $prefix := "" -}}
{{- if .global }}
  {{- $prefix = .global.nsPrefix | default "" -}}
{{- end -}}
{{- $namespace := .namespace | required "namespace is required" -}}
{{- if $prefix }}
  {{- printf "%s-%s" $prefix $namespace -}}
{{- else }}
  {{- $namespace -}}
{{- end -}}
{{- end -}}

{{/*
  Prefix multiple namespaces
  Usage:
    {{ include "helpers.prefixNamespaces" (dict "namespaces" .namespaces "global" $global_values) }}
*/}}
{{- define "helpers.prefixNamespaces" -}}
{{- $global := .global | required "global is required" -}}
{{- $namespaces := .namespaces | required "namespaces are required" -}}
{{- range $namespace := $namespaces }}
- {{ include "helpers.prefixNamespace" (dict "namespace" $namespace "global" $global) }}
{{- end -}}
{{- end -}}

{{/*
  Parse contents from file
  Usage:
  {{- $parsedData := include "helpers.parseYamlFile" (dict "Files" $files "Filename" .file) }}
*/}}
{{- define "helpers.parseYamlFile" -}}
{{- $fileContents := .Files.Get .Filename | fromYaml | default dict -}}
{{- range $key, $val := $fileContents }}
{{ $key }}: |
{{- $val | trim | nindent 4 }}
{{- end -}}
{{- end -}}

{{/*
A helper function to replace placeholders within a string with corresponding global values.
Returns the original value if no placeholders are found or if the corresponding global value is not found.
Returns an empty string only if the original value is empty.
Placeholder format: ^^global.<key>^^

For example if the global values are:
global:
  key1: value1
  key2: value2

And the input value is: "This is a ^^global.key1^^ example with ^^global.key2^^"
The output will be: "This is a value1 example with value2"

Parameters:
- dict:
  - "value": The main value to evaluate.
  - "global": The global values object.

Usage:
{{ include "helpers.renderGlobalIfExists" (dict "value" .yourValue "global" .Values.global) }}
*/}}
{{- define "helpers.renderGlobalIfExists" -}}
{{- $value := .value | default "" -}}
{{- $global := .global | default dict -}}

{{- if or (kindIs "int" $value) (kindIs "float64" $value) -}}
  {{- $value -}}
{{- else if and (kindIs "string" $value) (eq $value "") -}}
  {{- "" -}}
{{- else if eq (len $global) 0 -}}
  {{- $value -}}
{{- else -}}
  {{- range $key, $val := $global }}
    {{- if kindIs "string" $val -}}
      {{- $placeholder := printf "^^global.%s^^" $key -}}
      {{- $value = $value | replace $placeholder $val -}}
    {{- end -}}
  {{- end -}}
  {{- $value -}}
{{- end -}}
{{- end -}}