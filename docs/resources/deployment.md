# Deployment

## Parameters for `deployments`

| Parameter              | Type         | Required | Description                                                                                                  |
| ---------------------- | ------------ | -------- | ------------------------------------------------------------------------------------------------------------ |
| `deployments`          | List of maps | Yes      | A list containing deployment configurations. Each item in the list defines a deployment.                     |
| `name`                 | string       | Yes      | The name of the deployment. If not provided, the `fullname` helper function will be used to generate a name. |
| `disabled`              | boolean      | No       | If true, disables the deployment.                                                                            |
| `namespace`            | string       | Yes      | The namespace in which the deployment should be created.                                                     |
| `replicas`             | integer      | No       | The number of desired pod replicas. This is ignored if `autoscaling` is enabled in `deployment_defaults`.    |
| `revisionHistoryLimit` | integer      | No       | The number of old ReplicaSets to retain for rollback purposes.                                               |
| `strategy`             | object       | No       | The deployment strategy (e.g., `RollingUpdate`, `Recreate`).                                                 |
| `labels`               | map          | No       | Custom labels for the deployment.                                                                            |
| `annotations`          | map          | No       | Annotations for the deployment metadata.                                                                     |
| `reloaderEnabled`      | boolean      | No       | If true, enables specific reloader annotations.                                                              |
| `podAnnotations`       | map          | No       | Annotations to be added to the pod template.                                                                 |
| `podLabels`            | map          | No       | Custom labels for the pod template.                                                                          |
| `serviceAccountName`   | string       | No       | The service account name used by the deployment. Defaults to `serviceAccountName` in `deployment_defaults`.  |

## Container-Level Parameters

| Parameter                               | Type                | Required | Description                                                                |
| --------------------------------------- | ------------------- | -------- | -------------------------------------------------------------------------- |
| `containers`                            | List of maps        | Yes      | A list of container configurations within the deployment.                  |
| `containers[].name`                     | string              | Yes      | The name of the container.                                                 |
| `containers[].image`                    | object              | Yes      | Details for the container image.                                           |
| `containers[].image.registry`           | string              | Yes      | The registry where the image is stored.                                    |
| `containers[].image.repository`         | string              | Yes      | The repository of the image.                                               |
| `containers[].image.tag`                | string              | Yes      | The image tag (version).                                                   |
| `containers[].imagePullPolicy`          | string              | No       | The pull policy for the image (e.g., `Always`, `IfNotPresent`).            |
| `containers[].ports`                    | List of maps        | No       | Ports exposed by the container.                                            |
| `containers[].ports[].containerPort`    | integer             | Yes      | The port number.                                                           |
| `containers[].livenessProbe`            | object              | No       | Liveness probe settings for the container.                                 |
| `containers[].readinessProbe`           | object              | No       | Readiness probe settings for the container.                                |
| `containers[].startupProbe`             | object              | No       | Startup probe settings for the container.                                  |
| `containers[].env`                      | List of maps        | No       | Environment variables for the container.                                   |
| `containers[].envFrom`                  | List of maps        | No       | Environment sources for the container (e.g., `configMapRef`, `secretRef`). |
| `containers[].volumeMounts`             | List of maps or map | No       | Volumes to be mounted into the container.                                  |
| `containers[].volumeMounts[].name`      | string              | Yes      | The name of the volume mount.                                              |
| `containers[].volumeMounts[].mountPath` | string              | Yes      | The path where the volume is mounted.                                      |
| `containers[].volumeMounts[].subPath`   | string              | No       | A sub-path inside the volume.                                              |
| `containers[].volumeMounts[].readOnly`  | boolean             | No       | If true, sets the mount as read-only.                                      |
| `containers[].resources`                | object              | No       | Resource requests and limits for the container.                            |
| `containers[].securityContext`          | object              | No       | Security settings for the container.                                       |
| `containers[].command`                  | List of strings     | No       | The command to run in the container.                                       |
| `containers[].args`                     | List of strings     | No       | Arguments for the container’s command.                                     |

## Init Containers-Level Parameters

| Parameter                       | Type            | Required | Description                                                                     |
|---------------------------------|-----------------|----------|---------------------------------------------------------------------------------|
| `initContainers`                | List of maps    | No       | Configuration for init containers.                                              |
| `initContainers[].name`         | string          | Yes      | The name of the init container.                                                 |
| `initContainers[].image`        | object          | Yes      | The image details for the init container.                                       |
| `initContainers[].command`      | List of strings | No       | The command to run in the init container.                                       |
| `initContainers[].args`         | List of strings | No       | Arguments for the init container.                                               |
| `initContainers[].env`          | List of maps    | No       | Environment variables for the init container.                                   |
| `containers[].envFrom`          | List of maps    | No       | Environment sources for the init container (e.g., `configMapRef`, `secretRef`). |
| `initContainers[].volumeMounts` | List of maps    | No       | Volumes to mount into the init container.                                       |
| `initContainers[].resources`    | object          | No       | Resource requests and limits for the init container.                            |

## Other Parameters

| Parameter                         | Type                | Required | Description                                    |
| --------------------------------- | ------------------- | -------- | ---------------------------------------------- |
| `volumes`                         | List of maps or map | No       | Volumes available to be mounted by containers. |
| `volumes[].name`                  | string              | Yes      | The name of the volume.                        |
| `volumes[].projected`             | map                 | No       | Projected volume configuration.                |
| `volumes[].secret`                | map                 | No       | Secret configuration.                          |
| `volumes[].secret.secretName`     | string              | Yes      | The name of the secret.                        |
| `volumes[].configMap`             | map                 | No       | ConfigMap configuration.                       |
| `volumes[].configMap.name`        | string              | Yes      | The name of the ConfigMap.                     |
| `volumes[].configMap.defaultMode` | integer             | No       | Default mode for items in the ConfigMap.       |
| `volumes[].configMap.items`       | List of maps        | No       | Key-path pairs from the ConfigMap.             |
| `hostAliases`                     | List of maps        | No       | Custom host file entries.                      |
| `affinity`                        | object              | No       | Affinity rules for scheduling the pods.        |
| `nodeSelector`                    | map                 | No       | Node selection criteria.                       |
| `tolerations`                     | List of maps        | No       | Tolerations for pod scheduling.                |
| `priorityClassName`               | string              | No       | Priority class name for the pod.               |
| `topologySpreadConstraints`       | List of maps        | No       | Constraints to spread pods across nodes.       |
| `schedulerName`                   | string              | No       | Scheduler to be used for the pods.             |
| `terminationGracePeriodSeconds`   | integer             | No       | Grace period for pod termination.              |
| `securityContext`                 | object              | No       | Pod-level security settings.                   |

## Example of a Simple Deployment

```yaml
deployments:
  - name: api
    namespace: my-namespace
    replicas: 1
    containers:
      - name: api-container
        image:
          registry: docker.io
          repository: busybox
          tag: 1.0.0
        ports:
          - containerPort: 8080
        envFrom:
          - configMapRef:
              name: api-configmap
```
