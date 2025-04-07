# PDB

## Parameters for `PDB`

| Parameter      | Type        | Required | Description                                                                                  |
|----------------|-------------|----------|----------------------------------------------------------------------------------------------|
| `pdbs`         | Map of maps | Yes      | A list containing pdbs configurations. Each item in the list defines an PDB.                 |
| `name`         | string      | Yes      | The name of the PDB. This field is mandatory.                                                |
| `disabled`     | boolean     | No       | If true, disables the PDB.                                                                   |
| `namespace`    | string      | Yes      | The namespace in which the PDB should be created.                                            |
| `labels`       | map         | No       | Custom labels for the PDB.                                                                   |
| `annotations`  | map         | No       | Annotations for the PDB metadata.                                                            |
| `minAvailable` | string      | No       | The minimum number of pods that must be available after the eviction (pods num or percents). |
| `matchLabels`  | map         | Yes      | A map of key-value pairs to match labels of the pods to be selected                          |

## Example of a Simple PDB

```yaml
pdbs:
  example:
    name: example-pdb
    namespace: my-namespace
    annotations:
    minAvailable: 100%
    matchLabels:
      app: example
```
