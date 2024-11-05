# XM Helm Global Templates Library Chart

The XM Helm Global Templates Library Chart provides a set of reusable Helm templates that can be used in your Helm charts.
This allows you to centralize common functionality and promote consistency across your Helm deployments.
To use the templates, you need to add the repository to your Helm client and include the library chart as a dependency in your Helm chart's Chart.yaml file.

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