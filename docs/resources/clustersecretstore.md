# ClusterSecretStore

## Parameters for `clustersecretstores`

| Parameter                                  | Type         | Required | Description                                                                                              |
| ------------------------------------------ | ------------ | -------- | -------------------------------------------------------------------------------------------------------- |
| `clustersecretstores`                      | List of maps | Yes      | A list containing ClusterSecretStore configurations. Each item in the list defines a ClusterSecretStore. |
| `name`                                     | string       | Yes      | The name of the ClusterSecretStore.                                                                      |
| `disable`                                  | bool         | No       | Disables the ClusterSecretStore.                                                                         |
| `labels`                                   | map          | No       | Custom labels for the ClusterSecretStore.                                                                |
| `annotations`                              | map          | No       | Annotations for the ClusterSecretStore metadata.                                                         |
| `controller`                               | string       | No       | The controller responsible for managing the ClusterSecretStore.                                          |
| `aws.region`                               | string       | Yes      | The AWS region where the secrets are managed.                                                            |
| `aws.auth.jwt.serviceAccountRef.name`      | string       | Yes      | The name of the service account for authentication.                                                      |
| `aws.auth.jwt.serviceAccountRef.namespace` | string       | Yes      | The namespace of the service account for authentication.                                                 |

> **Note:** We only support AWS Secrets Manager as a provider for now. If you need support for other providers, feel free to open an issue or a pull request.

## Example of a Simple ClusterSecretStore

```yaml
clustersecretstores:
  - name: example-clustersecretstore
    labels:
      app: my-app
    annotations:
      description: "This is an example ClusterSecretStore"
    controller: external-secrets-controller
    aws:
      region: us-west-2
      auth:
        jwt:
          serviceAccountRef:
            name: my-service-account
            namespace: my-namespace
```
