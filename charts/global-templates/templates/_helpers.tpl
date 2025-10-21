{{/*
Copyright (C) 2024 XM Cyber
Author: Devops Infra Team
*/}}

{{/*
  Render an array of env variables, the input can be a map or a slice.
  Usage: 
    {{- include "helpers.toEnvArray" (dict "container" . "global" $global_values "context" $) }}
*/}}
{{- define "helpers.toEnvArray" -}}
{{- $envArray := list -}}
{{- $global := .global -}}

{{/* Process regular env variables */}}
{{- if kindIs "map" .container.env }}
  {{- range $key, $value := .container.env }}
    {{- if kindIs "map" $value }}
      {{- $envArray = append $envArray (dict "name" $key "valueFrom" $value.valueFrom) -}}
    {{- else }}
      {{- $envArray = append $envArray (dict "name" $key "value" $value) -}}
    {{- end }}
  {{- end }}
{{- else if kindIs "slice" .container.env }}
  {{- $envArray = .container.env -}}
{{- end }}

{{- range $envArray }}
{{- if hasKey . "value" }}
{{- $renderedValue := include "helpers.renderGlobalIfExists" (dict "value" (.value | quote) "global" $global) }}
- name: {{ .name }}
  value: {{ $renderedValue }}
{{- else if hasKey . "valueFrom" }}
- name: {{ .name }}
  valueFrom:
    {{- toYaml .valueFrom | nindent 4 }}
{{- end }}
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
    {{- fail (printf "Image with key '%s' not found" $container.imageKey) -}}
  {{- end -}}
  {{- if not $imgConf.repository }}
    {{- fail (printf "Image repository must be provided for key '%s'" $container.imageKey) -}}
  {{- end -}}
  {{- if and (not $imgConf.registry) (not $registry) }}
    {{- fail (printf "Registry must be provided either in the image configuration for key '%s' or globally using 'global.registry'" $container.imageKey) -}}
  {{- end -}}
  {{- $_ := set $image "registry" (default $registry $imgConf.registry) -}}
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
{{- /* Apply global render to annotation values first, then template render */ -}}
{{- $globalValues := .context.Values.global | default dict }}
{{- $globalRenderedAnnotations := dict }}
{{- range $key, $value := $combinedAnnotations }}
  {{- if kindIs "string" $value }}
    {{- $renderedValue := include "helpers.renderGlobalIfExists" (dict "value" $value "global" $globalValues) }}
    {{- $globalRenderedAnnotations = set $globalRenderedAnnotations $key $renderedValue }}
  {{- else }}
    {{- $globalRenderedAnnotations = set $globalRenderedAnnotations $key $value }}
  {{- end }}
{{- end }}
{{- include "common.tplvalues.render" (dict "value" $globalRenderedAnnotations "context" .context) }}
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
{{- $namespace := include "helpers.renderGlobalIfExists" (dict "value" (.namespace | required "namespace is required") "global" .global) }}
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
{{- if not (.Files.Get .Filename) -}}
{{- fail (printf "Error: File %s does not exist" .Filename) -}}
{{- else -}}
{{- $fileContents := .Files.Get .Filename | fromYaml | default dict -}}
{{- range $key, $val := $fileContents }}
{{ $key }}: |
{{- $val | trim | nindent 4 }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- /*
A helper function to replace placeholders within a string with corresponding global values.
Supports nested values using dot notation.
Returns the original value if:
- No placeholders are found
- The corresponding global value path is not found
- The input is a number

Placeholder format: {{ global.path.to.value_name }}

Example global values:
global:
  db:
    host: localhost
    port: 5432
  api:
    key: secret

Input: "Connect to {{global.db.host}}:{{ global.db.port }} using {{global.api.key}}"
Output: "Connect to localhost:5432 using secret"

Parameters:
- dict:
  - "value": The main value to evaluate
  - "global": The global values object
*/ -}}
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
  {{- /* Find all placeholders matching {{global.path.to.value}} pattern */ -}}
  {{- $regex := "\\{{2}\\s*global\\.([\\w\\-\\.\\_]+)\\s*\\}{2}" -}}
  {{- $result := $value -}}
  
  {{- /* Process each placeholder found */ -}}
  {{- range $placeholder := regexFindAll $regex $value -1 -}}
    {{- /* Extract the path after 'global.' */ -}}
    {{- $path := regexFind "[\\w\\-\\.\\_]+" (regexFind "global\\.([\\w\\-\\.\\_]+)" $placeholder) -}}
    {{- $path = trimPrefix "global." $path -}}
    
    {{- /* Split path into parts and traverse the global object */ -}}
    {{- $current := $global -}}
    {{- $valid := true -}}
    {{- range $part := splitList "." $path -}}
      {{- if hasKey $current $part -}}
        {{- $current = index $current $part -}}
      {{- else -}}
        {{- $valid = false -}}
      {{- end -}}
    {{- end -}}
    
    {{- /* Replace placeholder with value if path is valid */ -}}
    {{- if and $valid (kindIs "string" $current) -}}
      {{- $result = replace $placeholder $current $result -}}
    {{- else if and $valid (or (kindIs "int" $current) (kindIs "float64" $current) (kindIs "bool" $current)) -}}
      {{- $result = replace $placeholder (printf "%v" $current) $result -}}
    {{- end -}}
  {{- end -}}
  
  {{- $result -}}
{{- end -}}
{{- end -}}