# Statefulset

## Parameters for `statefulsets`

| Parameter                         | Type                | Required | Description                                                                                                   |
| --------------------------------- | ------------------- | -------- | ------------------------------------------------------------------------------------------------------------- |
| `statefulsets`                    | List of maps        | Yes      | A list containing StatefulSet configurations. Each item in the list defines a StatefulSet.                    |
| `name`                            | string              | Yes      | The name of the StatefulSet. If not provided, the `fullname` helper function will be used to generate a name. |
| `disabled`                        | boolean             | No       | If true, disables the StatefulSet.                                                                            |
| `namespace`                       | string              | Yes      | The namespace in which the StatefulSet should be created.                                                     |
| `labels`                          | map                 | No       | Custom labels for the StatefulSet.                                                                            |
| `annotations`                     | map                 | No       | Annotations for the StatefulSet metadata.                                                                     |
| `reloaderEnabled`                 | boolean             | No       | If true, enables specific reloader annotations.                                                               |
| `replicas`                        | integer             | No       | The number of desired pod replicas. Ignored if `autoscaling` is enabled in `statefulset_defaults`.            |
| `revisionHistoryLimit`            | integer             | No       | The number of old ReplicaSets to retain for rollback purposes.                                                |
| `strategy`                        | object              | No       | The update strategy for the StatefulSet (e.g., `RollingUpdate`).                                              |
| `serviceName`                     | string              | Yes      | The name of the service that governs this StatefulSet.                                                        |
| `initContainers`                  | List of maps        | No       | Configuration for init containers.                                                                            |
| `initContainers[].name`           | string              | Yes      | The name of the init container.                                                                               |
| `initContainers[].image`          | object              | Yes      | The image details for the init container.                                                                     |
| `initContainers[].command`        | List of strings     | No       | The command to run in the init container.                                                                     |
| `initContainers[].args`           | List of strings     | No       | Arguments for the init container.                                                                             |
| `initContainers[].env`            | List of maps        | No       | Environment variables for the init container.                                                                 |
| `initContainers[].volumeMounts`   | List of maps        | No       | Volumes to mount into the init container.                                                                     |
| `containers`                      | List of maps        | Yes      | A list of container configurations within the StatefulSet.                                                    |
| `containers[].name`               | string              | Yes      | The name of the container.                                                                                    |
| `containers[].image`              | object              | Yes      | Details for the container image.                                                                              |
| `containers[].imagePullPolicy`    | string              | No       | The pull policy for the image (e.g., `Always`, `IfNotPresent`).                                               |
| `containers[].command`            | List of strings     | No       | The command to run in the container.                                                                          |
| `containers[].args`               | List of strings     | No       | Arguments for the container’s command.                                                                        |
| `containers[].env`                | List of maps        | No       | Environment variables for the container.                                                                      |
| `containers[].envFrom`            | List of maps        | No       | Environment sources for the container (e.g., `configMapRef`, `secretRef`).                                    |
| `containers[].volumeMounts`       | List of maps or map | No       | Volumes to be mounted into the container.                                                                     |
| `containers[].ports`              | List of maps        | No       | Ports exposed by the container.                                                                               |
| `containers[].resources`          | object              | No       | Resource requests and limits for the container.                                                               |
| `containers[].securityContext`    | object              | No       | Security settings for the container.                                                                          |
| `containers[].livenessProbe`      | object              | No       | Liveness probe configuration.                                                                                 |
| `containers[].readinessProbe`     | object              | No       | Readiness probe configuration.                                                                                |
| `containers[].startupProbe`       | object              | No       | Startup probe configuration.                                                                                  |
| `containers[].lifecycle`          | object              | No       | Lifecycle hooks for the container.                                                                            |
| `volumes`                         | List of maps or map | No       | Volumes available to be mounted by containers.                                                                |
| `volumes[].name`                  | string              | Yes      | The name of the volume.                                                                                       |
| `volumes[].projected`             | map                 | No       | Projected volume configuration.                                                                               |
| `volumes[].secret`                | map                 | No       | Secret configuration.                                                                                         |
| `volumes[].secret.secretName`     | string              | Yes      | The name of the secret.                                                                                       |
| `volumes[].secret.items`          | List of maps        | No       | Key-path pairs from the secret.                                                                               |
| `volumes[].configMap`             | map                 | No       | ConfigMap configuration.                                                                                      |
| `volumes[].configMap.name`        | string              | Yes      | The name of the ConfigMap.                                                                                    |
| `volumes[].configMap.defaultMode` | integer             | No       | Default mode for items in the ConfigMap.                                                                      |
| `hostAliases`                     | List of maps        | No       | Custom host file entries.                                                                                     |
| `affinity`                        | object              | No       | Affinity rules for scheduling the pods.                                                                       |
| `nodeSelector`                    | map                 | No       | Node selection criteria.                                                                                      |
| `tolerations`                     | List of maps        | No       | Tolerations for pod scheduling.                                                                               |
| `priorityClassName`               | string              | No       | Priority class name for the pod.                                                                              |
| `topologySpreadConstraints`       | List of maps        | No       | Constraints to spread pods across nodes.                                                                      |
| `schedulerName`                   | string              | No       | Scheduler to be used for the pods.                                                                            |
| `securityContext`                 | object              | No       | Pod-level security settings.                                                                                  |
| `enableServiceLinks`              | boolean             | No       | Whether service environment variables are enabled.                                                            |
| `terminationGracePeriodSeconds`   | integer             | No       | Grace period for pod termination.                                                                             |
| `volumeClaimTemplates`            | List of maps        | No       | PersistentVolumeClaim templates for the StatefulSet.                                                          |

## Example of a Simple StatefulSet

```yaml
statefulsets:
  - name: example-statefulset
    namespace: my-namespace
    replicas: 2
    serviceName: example-service
    containers:
      - name: example-container
        image:
          registry: docker.io
          repository: nginx
          tag: latest
        ports:
          - containerPort: 80
```
