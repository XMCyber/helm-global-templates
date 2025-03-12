# RoleBinding

## Parameters for `rolebindings`

| Parameter              | Type         | Required | Description                                                                                                   |
| ---------------------- | ------------ | -------- | ------------------------------------------------------------------------------------------------------------- |
| `rolebindings`         | List of maps | Yes      | A list containing RoleBinding configurations. Each item in the list defines a RoleBinding.                    |
| `name`                 | string       | Yes      | The name of the RoleBinding. If not provided, the `fullname` helper function will be used to generate a name. |
| `disabled`              | boolean      | No       | If true, disables the RoleBinding.                                                                            |
| `namespace`            | string       | Yes      | The namespace in which the RoleBinding should be created.                                                     |
| `labels`               | map          | No       | Custom labels for the RoleBinding.                                                                            |
| `annotations`          | map          | No       | Annotations for the RoleBinding metadata.                                                                     |
| `subjects`             | List of maps | Yes      | A list of subjects (users, groups, or service accounts) bound to the Role or ClusterRole.                     |
| `subjects[].kind`      | string       | Yes      | The type of subject (e.g., `User`, `Group`, `ServiceAccount`).                                                |
| `subjects[].name`      | string       | Yes      | The name of the subject.                                                                                      |
| `subjects[].namespace` | string       | Yes      | The namespace of the subject. Required if `kind` is `ServiceAccount`.                                         |
| `roleRef`              | map          | Yes      | The reference to the Role or ClusterRole being bound.                                                         |
| `roleRef.kind`         | string       | Yes      | The type of role reference (`Role` or `ClusterRole`).                                                         |
| `roleRef.name`         | string       | Yes      | The name of the role being referenced.                                                                        |
| `roleRef.apiGroup`     | string       | Yes      | The API group of the role. Defaults to `rbac.authorization.k8s.io`.                                           |

## Example of a Simple RoleBinding

```yaml
rolebindings:
  - name: example-rolebinding
    namespace: my-namespace
    labels:
      app: my-app
    annotations:
      description: "This is an example RoleBinding"
    subjects:
      - kind: User
        name: example-user
        apiGroup: rbac.authorization.k8s.io
      - kind: ServiceAccount
        name: example-service-account
        namespace: my-namespace
    roleRef:
      kind: Role
      name: example-role
      apiGroup: rbac.authorization.k8s.io
```
