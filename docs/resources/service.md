# Service

## Parameters for `services`

| Parameter                  | Type              | Required | Description                                                                                                  |
| -------------------------- | ----------------- | -------- | ------------------------------------------------------------------------------------------------------------ |
| `services`                 | List of maps      | Yes      | A list containing service configurations. Each item in the list defines a service.                           |
| `name`                     | string            | Yes      | The name of the service. This field is mandatory.                                                            |
| `disabled`                  | boolean           | No       | If true, disables the service.                                                                               |
| `namespace`                | string            | Yes      | The namespace in which the service should be created.                                                        |
| `type`                     | string            | No       | The type of service (e.g., `ClusterIP`, `NodePort`, `LoadBalancer`). Defaults to `ClusterIP`.                |
| `labels`                   | map               | No       | Custom labels for the service.                                                                               |
| `annotations`              | map               | No       | Annotations for the service metadata.                                                                        |
| `selector`                 | map               | No       | The selector labels used to identify the pods targeted by the service.                                       |
| `sessionAffinity`          | string            | No       | The session affinity setting (e.g., `None`, `ClientIP`).                                                     |
| `sessionAffinityConfig`    | map               | No       | Configuration for session affinity settings.                                                                 |
| `clusterIP`                | string            | No       | The cluster IP address. Only applicable for services of type `ClusterIP`.                                    |
| `loadBalancerIP`           | string            | No       | The IP address for the load balancer. Only applicable for services of type `LoadBalancer`.                   |
| `loadBalancerSourceRanges` | List of strings   | No       | A list of allowed IP ranges for external access to the load balancer.                                        |
| `externalTrafficPolicy`    | string            | No       | The external traffic policy (e.g., `Cluster`, `Local`). Required for `LoadBalancer` and `NodePort` services. |
| `ports`                    | List of maps      | Yes      | A list of port configurations for the service.                                                               |
| `ports[].port`             | integer           | Yes      | The port that the service will expose.                                                                       |
| `ports[].targetPort`       | integer or string | No       | The port on the pod to which traffic will be directed.                                                       |
| `ports[].protocol`         | string            | No       | The protocol used by the service (e.g., `TCP`, `UDP`). Defaults to `TCP`.                                    |
| `ports[].nodePort`         | integer           | No       | The node port for `NodePort` type services.                                                                  |

## Example of a Simple Service

```yaml
services:
  - name: api-service
    namespace: my-namespace
    type: ClusterIP
    ports:
      - port: 80
        targetPort: 8080
    selector:
      app: api
    annotations:
      prometheus.io/scrape: "true"
      prometheus.io/port: "80"
```
