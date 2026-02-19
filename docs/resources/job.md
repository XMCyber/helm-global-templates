# Job

## Parameters for `jobs`

| Parameter              | Type         | Required | Description                                                                                                  |
| ---------------------- | ------------ | -------- | ------------------------------------------------------------------------------------------------------------ |
| `jobs`                 | Map of maps  | Yes      | A map containing Job configurations. Each key defines a Job.                                                 |
| `name`                 | string       | Yes      | The name of the Job. If not provided, the `fullname` helper function will be used to generate a name.        |
| `disabled`             | boolean      | No       | If true, disables the Job.                                                                                   |
| `namespace`            | string       | Yes      | The namespace in which the Job should be created.                                                            |
| `labels`               | map          | No       | Custom labels for the Job.                                                                                   |
| `annotations`          | map          | No       | Annotations for the Job metadata.                                                                            |
| `podAnnotations`       | map          | No       | Annotations to be added to the pod template.                                                                 |
| `podLabels`            | map          | No       | Custom labels for the pod template.                                                                          |

## Job Spec Parameters

| Parameter                     | Type    | Required | Description                                                               |
| ----------------------------- | ------- | -------- | ------------------------------------------------------------------------- |
| `activeDeadlineSeconds`       | integer | No       | Maximum time in seconds that a job can run before being terminated.       |
| `backoffLimit`                | integer | No       | Number of retries before marking the job as failed. Defaults to `6`.     |
| `completions`                 | integer | No       | Number of successful completions required for the job.                   |
| `parallelism`                 | integer | No       | Maximum number of pods that can run in parallel.                         |
| `completionMode`              | string  | No       | Completion mode for the job (`NonIndexed` or `Indexed`).                 |
| `ttlSecondsAfterFinished`     | integer | No       | Time in seconds after which a completed job is eligible for cleanup.     |
| `restartPolicy`               | string  | No       | Restart policy for pods (`Never`, `OnFailure`). Defaults to `Never`.     |
| `serviceAccountName`          | string  | No       | The service account name used by the job pods.                           |

## Init Container Parameters

| Parameter                               | Type                | Required | Description                                                                |
| --------------------------------------- | ------------------- | -------- | -------------------------------------------------------------------------- |
| `initContainers`                        | List of maps        | No       | A list of init container configurations to run before the main containers. |
| `initContainers[].name`                 | string              | Yes      | The name of the init container.                                            |
| `initContainers[].image`                | object              | Yes      | Details for the init container image.                                      |
| `initContainers[].image.registry`       | string              | Yes      | The registry where the image is stored.                                    |
| `initContainers[].image.repository`     | string              | Yes      | The repository of the image.                                               |
| `initContainers[].image.tag`            | string              | Yes      | The image tag (version).                                                   |
| `initContainers[].imagePullPolicy`      | string              | No       | The pull policy for the image.                                             |
| `initContainers[].command`              | List of strings     | No       | The command to run in the init container.                                  |
| `initContainers[].args`                 | List of strings     | No       | Arguments for the init container's command.                                |
| `initContainers[].env`                  | List of maps        | No       | Environment variables for the init container.                              |
| `initContainers[].envFrom`              | List of maps        | No       | Environment sources for the init container.                                |
| `initContainers[].volumeMounts`         | List of maps        | No       | Volumes to be mounted into the init container.                             |
| `initContainers[].resources`            | object              | No       | Resource requests and limits for the init container.                       |

## Container-Level Parameters

| Parameter                               | Type                | Required | Description                                                                |
| --------------------------------------- | ------------------- | -------- | -------------------------------------------------------------------------- |
| `containers`                            | List of maps        | Yes      | A list of container configurations within the Job.                         |
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
| `containers[].args`                     | List of strings     | No       | Arguments for the container's command.                                     |
| `containers[].lifecycle`                | object              | No       | Lifecycle hooks for the container.                                         |

## Volume-Level Parameters

| Parameter                              | Type             | Required | Description                                                  |
| -------------------------------------- | ---------------- | -------- | ------------------------------------------------------------ |
| `volumes`                              | List of maps     | No       | A list of volumes for the Job.                               |
| `volumes[].name`                       | string           | Yes      | The name of the volume.                                      |
| `volumes[].secret`                     | object           | No       | Secret volume configuration.                                 |
| `volumes[].secret.secretName`          | string           | Yes      | The name of the secret.                                      |
| `volumes[].configMap`                  | object           | No       | ConfigMap volume configuration.                              |
| `volumes[].configMap.name`             | string           | Yes      | The name of the ConfigMap.                                   |
| `volumes[].configMap.items`            | List of maps     | No       | Specific items from the ConfigMap.                           |
| `volumes[].configMap.items[].key`      | string           | Yes      | The key in the ConfigMap.                                    |
| `volumes[].configMap.items[].path`     | string           | Yes      | The path where the key should be mounted.                    |
| `volumes[].configMap.defaultMode`      | integer          | No       | Default file mode for ConfigMap items.                       |
| `volumes[].projected`                  | object           | No       | Projected volume configuration.                              |

## Pod-Level Parameters

| Parameter                        | Type         | Required | Description                                                 |
| -------------------------------- | ------------ | -------- | ----------------------------------------------------------- |
| `imagePullSecrets`               | List of maps | No       | Secrets for pulling images.                                 |
| `imagePullSecrets[].name`        | string       | Yes      | The name of the image pull secret.                          |
| `hostAliases`                    | List of maps | No       | Host aliases for the pod.                                   |
| `affinity`                       | object       | No       | Affinity settings for the pod.                              |
| `podAffinityPreset`              | string       | No       | Pod affinity preset.                                        |
| `podAntiAffinityPreset`          | string       | No       | Pod anti-affinity preset.                                   |
| `nodeSelector`                   | map          | No       | Node selector for the pod.                                  |
| `tolerations`                    | List of maps | No       | Tolerations for the pod.                                    |
| `tolerations[].key`              | string       | Yes      | The key of the toleration.                                  |
| `tolerations[].operator`         | string       | No       | The operator for the toleration.                            |
| `tolerations[].value`            | string       | Yes      | The value of the toleration.                                |
| `tolerations[].effect`           | string       | No       | The effect of the toleration.                               |
| `tolerations[].tolerationSeconds` | integer     | No       | The duration the toleration is valid.                       |
| `priorityClassName`              | string       | No       | Priority class name for the pod.                            |
| `topologySpreadConstraints`      | List of maps | No       | Topology spread constraints for the pod.                    |
| `schedulerName`                  | string       | No       | Custom scheduler name for the pod.                          |
| `securityContext`                | object       | No       | Security context for the pod.                               |
| `terminationGracePeriodSeconds`  | integer      | No       | Grace period for pod termination.                           |

## Example Usage

```yaml
jobs:
  db-migration:
    name: db-migration
    namespace: production
    backoffLimit: 3
    ttlSecondsAfterFinished: 300
    activeDeadlineSeconds: 600
    restartPolicy: Never
    annotations:
      argocd.argoproj.io/hook: PreSync
      argocd.argoproj.io/hook-delete-policy: BeforeHookCreation
    initContainers:
      - name: wait-for-db
        image:
          registry: docker.io
          repository: busybox
          tag: "1.35.0"
        command:
          - /bin/sh
          - -c
          - "until nc -z db-host 5432; do sleep 2; done"
        resources:
          requests:
            cpu: 50m
            memory: 64Mi
    containers:
      - name: migration
        image:
          registry: docker.io
          repository: my-org/migration
          tag: "v2.0.0"
        command:
          - /bin/sh
          - -c
          - "run-migration.sh"
        env:
          DB_HOST:
            valueFrom:
              secretKeyRef:
                name: db-credentials
                key: DB_HOST
          DB_PASSWORD:
            valueFrom:
              secretKeyRef:
                name: db-credentials
                key: DB_PASSWORD
        envFrom:
          - configMapRef:
              name: migration-config
        resources:
          requests:
            cpu: 100m
            memory: 256Mi
          limits:
            cpu: 500m
            memory: 512Mi

  data-seed:
    name: data-seed
    namespace: production
    backoffLimit: 1
    restartPolicy: Never
    containers:
      - name: seed
        image:
          registry: docker.io
          repository: my-org/seed
          tag: "v1.0.0"
        command:
          - /bin/sh
          - -c
          - "seed-data.sh"
        resources:
          requests:
            cpu: 50m
            memory: 128Mi
```

## Default Values

The following default values are applied from `job_defaults`:

```yaml
job_defaults:
  backoffLimit: 6
  restartPolicy: Never
  imagePullPolicy: IfNotPresent
  serviceAccountName: default
  nodeAffinityPreset:
    type: ""
  resources:
    requests:
      cpu: 0.1
      memory: 0.5Gi
```

## Notes

- Jobs are useful for one-off tasks such as database migrations, data seeding, batch processing, and cleanup operations
- Unlike CronJobs, Jobs run immediately upon creation and do not have a schedule
- The `restartPolicy` for Job pods should typically be `Never` or `OnFailure`
- Use `ttlSecondsAfterFinished` to automatically clean up completed Job resources
- Use `activeDeadlineSeconds` to set a maximum runtime for the Job
- Jobs support `initContainers` for pre-flight checks (e.g., waiting for a database to be ready)
- Jobs work well with ArgoCD hooks (`PreSync`, `PostSync`) for deployment workflows like migrations
- Use annotations like `argocd.argoproj.io/hook: PreSync` and `argocd.argoproj.io/hook-delete-policy: BeforeHookCreation` for ArgoCD integration
