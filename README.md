# XM Helm Global Templates Library Chart

The XM Helm Global Templates Library Chart provides a set of reusable Helm templates to simplify and standardize Helm chart development.
By centralizing commonly used templates, it helps maintain consistency across charts and makes it easier for developers to define and manage their services without complex Helm syntax.

## Installation

### Add the Repository

```bash
helm repo add xm-global-templates https://xmcyber.github.io/helm-global-templates/
```

### Add the Dependency

Add the following to your Helm chart's Chart.yaml file:

```yaml
dependencies:
  - name: xm-global-templates
    version: 1.0.1 # Use the latest version
    repository: https://xmcyber.github.io/helm-global-templates/
    import-values:
      - default
```

## Usage

### Include Global Templates

In your chart you only need a single template file to include the global templates, you should include the templates you want to render in your specific chart.
Here's an example of how to use the global templates for a chart that consists of a Deployment, Service and Configmap:

```yaml
{{ include "global-templates.deployment" (dict "deployments" .Values.deployments "Chart" .Chart "Release" .Release "Capabilities" .Capabilities "Files" .Files "Template" .Template "Values" .Values) }}
{{ include "global-templates.service" (dict "services" .Values.services "Chart" .Chart "Release" .Release "Capabilities" .Capabilities "Files" .Files "Template" .Template "Values" .Values) }}
{{ include "global-templates.configmap" (dict "configmaps" .Values.configmaps "Chart" .Chart "Release" .Release "Capabilities" .Capabilities "Files" .Files "Template" .Template "Values" .Values) }}
```

### Values File Example

Define your resources in the `values.yaml` file to be rendered by the global templates:

```yaml
api_port: &api_port 3000
api_namespace: &api_namespace api-namespace
api_configmap_name: &api_configmap_name api-cm

deployments:
  - name: api
    namespace: *api_namespace
    replicas: 1
    containers:
      - name: api-container
        image:
          registry: docker.io
          repository: busybox
          tag: 1.0.0
        ports:
          - containerPort: *api_port
        envFrom:
          - configMapRef:
              name: *api_configmap_name

services:
  - name: api
    namespace: *api_namespace
    ports:
      - port: *api_port
        targetPort: *api_port
        protocol: TCP

configmaps:
  - name: *api_configmap_name
    namespace: *api_namespace
    data:
      key: value
```
