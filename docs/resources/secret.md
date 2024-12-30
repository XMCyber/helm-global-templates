# Secret

## Parameters for `secrets`

| Parameter     | Type         | Required | Description                                                                                   |
| ------------- | ------------ | -------- | --------------------------------------------------------------------------------------------- |
| `secrets`     | List of maps | Yes      | A list containing Secret configurations. Each item in the list defines a Secret.              |
| `name`        | string       | Yes      | The name of the Secret. This field is mandatory.                                              |
| `disable`     | bool         | No       | Disables the Secret.                                                                          |
| `namespace`   | string       | Yes      | The namespace in which the Secret should be created.                                          |
| `labels`      | map          | No       | Custom labels for the Secret.                                                                 |
| `annotations` | map          | No       | Annotations for the Secret metadata.                                                          |
| `type`        | string       | No       | The type of the Secret (e.g., `Opaque`). Defaults to `Opaque`.                                |
| `data`        | map          | No       | Key-value pairs representing the data for the Secret, base64-encoded.                         |
| `file`        | string       | No       | A path to a file whose contents will be used as the data for the Secret.                      |
| `stringData`  | map          | No       | Key-value pairs representing the string data for the Secret. This data is not base64-encoded. |

## Example of a Simple Secret

```yaml
secrets:
  - name: example-secret
    namespace: my-namespace
    labels:
      app: my-app
    annotations:
      description: "This is an example Secret"
    type: Opaque
    data:
      key1: bXktdmFsdWU=
      key2: bXktb3RoZXItdmFsdWU=
    stringData:
      plainKey: plainValue
```
