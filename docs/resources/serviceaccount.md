# ServiceAccount

## Parameters for `serviceaccounts`

| Parameter         | Type         | Required | Description                                                                                                      |
| ----------------- | ------------ | -------- | ---------------------------------------------------------------------------------------------------------------- |
| `serviceaccounts` | List of maps | Yes      | A list containing ServiceAccount configurations. Each item in the list defines a ServiceAccount.                 |
| `name`            | string       | Yes      | The name of the ServiceAccount. If not provided, the `fullname` helper function will be used to generate a name. |
| `disable`         | boolean      | No       | If true, disables the ServiceAccount.                                                                            |
| `namespace`       | string       | Yes      | The namespace in which the ServiceAccount should be created.                                                     |
| `labels`          | map          | No       | Custom labels for the ServiceAccount.                                                                            |
| `annotations`     | map          | No       | Annotations for the ServiceAccount metadata.                                                                     |

## Example of a Simple ServiceAccount

```yaml
serviceaccounts:
  - name: example-serviceaccount
    namespace: my-namespace
    labels:
      app: my-app
    annotations:
      description: "This is an example ServiceAccount"
```
