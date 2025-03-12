# SealedSecret

## Parameters for `sealedsecrets`

| Parameter       | Type         | Required | Description                                                                                            |
| --------------- | ------------ | -------- | ------------------------------------------------------------------------------------------------------ |
| `sealedsecrets` | List of maps | Yes      | A list containing SealedSecret configurations. Each item in the list defines a SealedSecret.           |
| `name`          | string       | Yes      | The name of the SealedSecret.                                                                          |
| `disabled`       | boolean      | No       | If true, disables the SealedSecret.                                                                    |
| `namespace`     | string       | Yes      | The namespace in which the SealedSecret should be created.                                             |
| `annotations`   | map          | No       | Annotations for the SealedSecret metadata.                                                             |
| `encryptedData` | map          | No       | Map of encrypted data. Keys are the secret keys, values are the corresponding encrypted secret values. |

## Example of a Simple SealedSecret

```yaml
sealedsecrets:
  - name: example-sealed-secret
    namespace: my-namespace
    annotations:
      description: "This is an example SealedSecret"
    encryptedData:
      username: AgBy8vHJGJ...
      password: AgBy8vHJGJ...
```
