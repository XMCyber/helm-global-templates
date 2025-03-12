# ExternalSecret

## Parameters for `externalsecrets`

| Parameter                             | Type         | Required | Description                                                                                           |
| ------------------------------------- | ------------ | -------- | ----------------------------------------------------------------------------------------------------- |
| `externalsecrets`                     | List of maps | Yes      | A list containing ExternalSecret configurations. Each item in the list defines an ExternalSecret.     |
| `name`                                | string       | Yes      | The name of the ExternalSecret. This field is mandatory.                                              |
| `disabled`                             | boolean      | No       | If true, disables the ExternalSecret.                                                                 |
| `namespace`                           | string       | Yes      | The namespace in which the ExternalSecret should be created.                                          |
| `labels`                              | map          | No       | Custom labels for the ExternalSecret.                                                                 |
| `annotations`                         | map          | No       | Annotations for the ExternalSecret metadata.                                                          |
| `refreshInterval`                     | string       | No       | The interval at which the secret is refreshed. Defaults to `externalsecret_defaults.refreshInterval`. |
| `secretStoreRef`                      | map          | Yes      | A reference to the secret store. Must include `name` and can optionally include `kind`.               |
| `secretStoreRef.name`                 | string       | Yes      | The name of the secret store.                                                                         |
| `secretStoreRef.kind`                 | string       | No       | The kind of the secret store. Defaults to `SecretStore`.                                              |
| `target`                              | map          | Yes      | Configuration for the target secret that will be created from the ExternalSecret.                     |
| `target.name`                         | string       | Yes      | The name of the target secret. Defaults to the name of the ExternalSecret.                            |
| `target.creationPolicy`               | string       | No       | The creation policy for the target secret. Defaults to `Owner`.                                       |
| `target.template`                     | map          | No       | A template for the target secret.                                                                     |
| `data`                                | List of maps | Yes      | A list of data entries for the ExternalSecret. Each entry specifies a `secretKey` and a `remoteRef`.  |
| `data[].secretKey`                    | string       | Yes      | The key under which the data will be stored in the target secret.                                     |
| `data[].remoteRef`                    | map          | Yes      | A reference to the remote secret key.                                                                 |
| `data[].remoteRef.key`                | string       | Yes      | The key in the remote secret.                                                                         |
| `data[].remoteRef.version`            | string       | No       | The version of the key in the remote secret.                                                          |
| `data[].remoteRef.property`           | string       | No       | The property to extract from the remote secret key.                                                   |
| `data[].remoteRef.decodingStrategy`   | string       | No       | The strategy for decoding the data.                                                                   |
| `data[].remoteRef.conversionStrategy` | string       | No       | The strategy for converting the data. Defaults to `Default`.                                          |
| `data[].remoteRef.metadataPolicy`     | string       | No       | The policy for handling metadata. Defaults to `None`.                                                 |
| `dataFrom`                            | List of maps | No       | A list of data entries for the ExternalSecret. Each entry specifies an `extract` configuration.       |
| `dataFrom[].extract`                  | map          | No       | Extract all keys from the remote secret.                                                              |
| `dataFrom[].extract.key`              | string       | Yes      | The key in the remote secret.                                                                         |

## Example of a Simple ExternalSecret

```yaml
externalsecrets:
  - name: example-externalsecret
    namespace: my-namespace
    labels:
      app: my-app
    annotations:
      description: "This is an example ExternalSecret"
    refreshInterval: "1h"
    secretStoreRef:
      name: my-secret-store
      kind: SecretStore
    target:
      name: example-target-secret
      creationPolicy: Owner
    data:
      - secretKey: example-key
        remoteRef:
          key: example-remote-key
          version: "1"
          property: propertyName
    dataFrom:
      - extract:
          key: another-remote-key
```
