# Configmap

## Parameters for `configmaps`

| Parameter      | Type            | Required | Description                                                                                                    |
| -------------- | --------------- | -------- | -------------------------------------------------------------------------------------------------------------- |
| `configmaps`   | List of maps    | Yes      | A list containing ConfigMap configurations. Each item in the list defines a ConfigMap.                         |
| `name`         | string          | Yes      | The name of the ConfigMap. This field is mandatory.                                                            |
| `disabled`      | bool            | No       | Disables the ConfigMap.                                                                                        |
| `namespace`    | string          | No       | The namespace in which the ConfigMap should be created. If not provided, it defaults to the release namespace. |
| `namespaces`   | List of strings | No       | A list of namespaces where the ConfigMap should be created. Overrides `namespace` if provided.                 |
| `labels`       | map             | No       | Custom labels for the ConfigMap.                                                                               |
| `annotations`  | map             | No       | Annotations for the ConfigMap metadata.                                                                        |
| `data`         | map             | No       | Key-value pairs representing the data to include in the ConfigMap.                                             |
| `file`         | string          | No       | A path to a file whose contents will be used as the data for the ConfigMap.                                    |
| `file_content` | map             | No       | Key-value pairs where the key is the data key, and the value is the file content to be embedded directly.      |

## Example of a Simple ConfigMap

```yaml
configmaps:
  - name: example-configmap
    namespace: my-namespace
    labels:
      app: my-app
    annotations:
      description: "This is an example ConfigMap"
    data:
      key1: value1
      key2: value2
```
