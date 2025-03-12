# Role

## Parameters for `roles`

| Parameter           | Type            | Required | Description                                                                                            |
| ------------------- | --------------- | -------- | ------------------------------------------------------------------------------------------------------ |
| `roles`             | List of maps    | Yes      | A list containing Role configurations. Each item in the list defines a Role.                           |
| `name`              | string          | Yes      | The name of the Role. If not provided, the `fullname` helper function will be used to generate a name. |
| `disabled`           | boolean         | No       | If true, disables the Role.                                                                            |
| `namespace`         | string          | Yes      | The namespace in which the Role should be created.                                                     |
| `labels`            | map             | No       | Custom labels for the Role.                                                                            |
| `annotations`       | map             | No       | Annotations for the Role metadata.                                                                     |
| `reloaderEnabled`   | boolean         | No       | If true, enables specific reloader annotations.                                                        |
| `rules`             | List of maps    | Yes      | A list of rules for the Role. Each rule defines the access control settings.                           |
| `rules[].apiGroups` | List of strings | Yes      | The API groups that the Role applies to.                                                               |
| `rules[].resources` | List of strings | Yes      | The resources that the Role has access to.                                                             |
| `rules[].verbs`     | List of strings | Yes      | The actions (verbs) that the Role is allowed to perform on the specified resources.                    |

## Example of a Simple Role

```yaml
roles:
  - name: example-role
    namespace: my-namespace
    labels:
      app: my-app
    annotations:
      description: "This is an example Role"
    rules:
      - apiGroups:
          - ""
        resources:
          - pods
        verbs:
          - get
          - list
          - watch
```
