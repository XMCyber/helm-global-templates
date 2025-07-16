# CronJob

## Parameters for `cronjobs`

| Parameter              | Type         | Required | Description                                                                                                  |
| ---------------------- | ------------ | -------- | ------------------------------------------------------------------------------------------------------------ |
| `cronjobs`             | List of maps | Yes      | A list containing CronJob configurations. Each item in the list defines a CronJob.                          |
| `name`                 | string       | Yes      | The name of the CronJob. If not provided, the `fullname` helper function will be used to generate a name.   |
| `disabled`             | boolean      | No       | If true, disables the CronJob.                                                                              |
| `namespace`            | string       | Yes      | The namespace in which the CronJob should be created.                                                       |
| `schedule`             | string       | Yes      | The cron schedule for the job (e.g., `"0 2 * * *"` for daily at 2 AM).                                     |
| `timeZone`             | string       | No       | The timezone for the schedule (e.g., `"UTC"`, `"America/New_York"`).                                        |
| `concurrencyPolicy`    | string       | No       | How to handle concurrent executions (`Allow`, `Forbid`, `Replace`). Defaults to `Forbid`.                    |
| `suspend`              | boolean      | No       | If true, suspends the CronJob.                                                                              |
| `successfulJobsHistoryLimit` | integer | No       | Number of successful jobs to keep in history. Defaults to `3`.                                              |
| `failedJobsHistoryLimit` | integer    | No       | Number of failed jobs to keep in history. Defaults to `1`.                                                  |
| `startingDeadlineSeconds` | integer   | No       | Deadline in seconds for starting the job if it misses its scheduled time.                                   |
| `labels`               | map          | No       | Custom labels for the CronJob.                                                                              |
| `annotations`          | map          | No       | Annotations for the CronJob metadata.                                                                       |
| `podAnnotations`       | map          | No       | Annotations to be added to the pod template.                                                                 |
| `podLabels`            | map          | No       | Custom labels for the pod template.                                                                          |

## Job Template Parameters

| Parameter                     | Type    | Required | Description                                                               |
| ----------------------------- | ------- | -------- | ------------------------------------------------------------------------- |
| `activeDeadlineSeconds`       | integer | No       | Maximum time in seconds that a job can run before being terminated.      |
| `backoffLimit`                | integer | No       | Number of retries before marking the job as failed. Defaults to `6`.     |
| `completions`                 | integer | No       | Number of successful completions required for the job.                   |
| `parallelism`                 | integer | No       | Maximum number of pods that can run in parallel.                         |
| `completionMode`              | string  | No       | Completion mode for the job (`NonIndexed` or `Indexed`).                 |
| `ttlSecondsAfterFinished`     | integer | No       | Time in seconds after which a completed job is eligible for cleanup.     |
| `restartPolicy`               | string  | No       | Restart policy for pods (`Never`, `OnFailure`). Defaults to `OnFailure`. |
| `serviceAccountName`          | string  | No       | The service account name used by the job pods.                           |

## Container-Level Parameters

| Parameter                               | Type                | Required | Description                                                                |
| --------------------------------------- | ------------------- | -------- | -------------------------------------------------------------------------- |
| `containers`                            | List of maps        | Yes      | A list of container configurations within the CronJob.                    |
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
| `volumes`                              | List of maps     | No       | A list of volumes for the CronJob.                          |
| `volumes[].name`                       | string           | Yes      | The name of the volume.                                      |
| `volumes[].secret`                     | object           | No       | Secret volume configuration.                                 |
| `volumes[].secret.secretName`          | string           | Yes      | The name of the secret.                                      |
| `volumes[].configMap`                  | object           | No       | ConfigMap volume configuration.                              |
| `volumes[].configMap.name`             | string           | Yes      | The name of the ConfigMap.                                   |
| `volumes[].configMap.items`            | List of maps     | No       | Specific items from the ConfigMap.                          |
| `volumes[].configMap.items[].key`      | string           | Yes      | The key in the ConfigMap.                                    |
| `volumes[].configMap.items[].path`     | string           | Yes      | The path where the key should be mounted.                   |
| `volumes[].configMap.defaultMode`      | integer          | No       | Default file mode for ConfigMap items.                      |
| `volumes[].projected`                  | object           | No       | Projected volume configuration.                              |

## Pod-Level Parameters

| Parameter                        | Type         | Required | Description                                                 |
| -------------------------------- | ------------ | -------- | ----------------------------------------------------------- |
| `imagePullSecrets`               | List of maps | No       | Secrets for pulling images.                                 |
| `imagePullSecrets[].name`        | string       | Yes      | The name of the image pull secret.                         |
| `hostAliases`                    | List of maps | No       | Host aliases for the pod.                                  |
| `affinity`                       | object       | No       | Affinity settings for the pod.                             |
| `podAffinityPreset`              | string       | No       | Pod affinity preset.                                       |
| `podAntiAffinityPreset`          | string       | No       | Pod anti-affinity preset.                                  |
| `nodeSelector`                   | map          | No       | Node selector for the pod.                                 |
| `tolerations`                    | List of maps | No       | Tolerations for the pod.                                   |
| `tolerations[].key`              | string       | Yes      | The key of the toleration.                                 |
| `tolerations[].operator`         | string       | No       | The operator for the toleration.                           |
| `tolerations[].value`            | string       | Yes      | The value of the toleration.                               |
| `tolerations[].effect`           | string       | No       | The effect of the toleration.                              |
| `tolerations[].tolerationSeconds` | integer     | No       | The duration the toleration is valid.                      |
| `priorityClassName`              | string       | No       | Priority class name for the pod.                          |
| `topologySpreadConstraints`      | List of maps | No       | Topology spread constraints for the pod.                   |
| `schedulerName`                  | string       | No       | Custom scheduler name for the pod.                         |
| `securityContext`                | object       | No       | Security context for the pod.                             |
| `terminationGracePeriodSeconds`  | integer      | No       | Grace period for pod termination.                          |

## Example Usage

```yaml
cronjobs:
  daily-backup:
    name: daily-backup
    namespace: production
    schedule: "0 2 * * *"
    timeZone: "UTC"
    concurrencyPolicy: Forbid
    successfulJobsHistoryLimit: 5
    failedJobsHistoryLimit: 3
    backoffLimit: 3
    activeDeadlineSeconds: 3600
    restartPolicy: OnFailure
    containers:
      - name: backup
        image:
          registry: docker.io
          repository: my-app/backup
          tag: "v1.0.0"
        command:
          - /bin/sh
          - -c
          - "backup-script.sh"
        env:
          BACKUP_PATH: "/data/backup"
          LOG_LEVEL: "INFO"
        envFrom:
          - configMapRef:
              name: backup-config
          - secretRef:
              name: backup-credentials
        resources:
          requests:
            cpu: 100m
            memory: 256Mi
          limits:
            cpu: 500m
            memory: 512Mi
        volumeMounts:
          data-volume:
            name: data-volume
            mountPath: /data
    volumes:
      data-volume:
        name: data-volume
        configMap:
          name: backup-config
          items:
            - key: config.yaml
              path: config.yaml
    annotations:
      description: "Daily backup job"
    labels:
      app.kubernetes.io/component: "backup"
    podAnnotations:
      prometheus.io/scrape: "false"
    podLabels:
      backup-type: "database"

  weekly-cleanup:
    name: weekly-cleanup
    namespace: production
    schedule: "0 0 * * 0"  # Every Sunday at midnight
    timeZone: "UTC"
    concurrencyPolicy: Replace
    containers:
      - name: cleanup
        image:
          registry: docker.io
          repository: my-app/cleanup
          tag: "v1.0.0"
        command:
          - /bin/sh
          - -c
          - "cleanup-script.sh"
        resources:
          requests:
            cpu: 50m
            memory: 128Mi
```

## Default Values

The following default values are applied from `cronjob_defaults`:

```yaml
cronjob_defaults:
  concurrencyPolicy: Forbid
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 1
  backoffLimit: 6
  restartPolicy: OnFailure
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

- The `schedule` field is **required** and must be a valid cron expression
- CronJobs are useful for running periodic tasks like backups, cleanup, reports, etc.
- The `concurrencyPolicy` determines how concurrent executions are handled:
  - `Allow`: Allows concurrent jobs
  - `Forbid`: Prevents concurrent jobs; skips new job if previous is still running (default)
  - `Replace`: Replaces the current job with a new one
- Use `suspend: true` to temporarily disable a CronJob without deleting it
- The `restartPolicy` for CronJob pods should typically be `OnFailure` or `Never`
