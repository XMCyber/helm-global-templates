# Ingress

## Parameters for `ingresses`

| Parameter                                          | Type            | Required | Description                                                                                       |
| -------------------------------------------------- | --------------- | -------- | ------------------------------------------------------------------------------------------------- |
| `ingresses`                                        | List of maps    | Yes      | A list containing Ingress configurations. Each item in the list defines an Ingress.               |
| `name`                                             | string          | Yes      | The name of the Ingress. This field is mandatory.                                                 |
| `disabled`                                          | boolean         | No       | If true, disables the Ingress.                                                                    |
| `namespace`                                        | string          | Yes      | The namespace in which the Ingress should be created.                                             |
| `labels`                                           | map             | No       | Custom labels for the Ingress.                                                                    |
| `annotations`                                      | map             | No       | Annotations for the Ingress metadata.                                                             |
| `ingressClassName`                                 | string          | No       | The ingress class name. If not provided, it defaults to `ingressClassName` in `ingress_defaults`. |
| `rules`                                            | List of maps    | No       | A list of rules for the Ingress. Each rule can include host and HTTP path configurations.         |
| `rules[].host`                                     | string          | No       | The host for the rule. Defaults to `host` in `ingress_defaults` if not provided.                  |
| `rules[].http.paths`                               | List of maps    | Yes      | A list of HTTP paths and backend services.                                                        |
| `rules[].http.paths[].path`                        | string          | No       | The path for the HTTP route. Defaults to `path` in `ingress_defaults` if not provided.            |
| `rules[].http.paths[].pathType`                    | string          | No       | The path type (e.g., `Prefix`, `Exact`). Defaults to `Prefix`.                                    |
| `rules[].http.paths[].backend.service.name`        | string          | Yes      | The name of the backend service.                                                                  |
| `rules[].http.paths[].backend.service.port.number` | integer         | Yes      | The port number for the backend service.                                                          |
| `tls`                                              | List of maps    | No       | A list of TLS configurations.                                                                     |
| `tls[].hosts`                                      | List of strings | Yes      | The hosts for the TLS configuration.                                                              |
| `tls[].secretName`                                 | string          | Yes      | The name of the secret containing the TLS certificate.                                            |

## Example of a Simple Ingress

```yaml
ingresses:
  - name: example-ingress
    namespace: my-namespace
    annotations:
      nginx.ingress.kubernetes.io/rewrite-target: "/"
    ingressClassName: nginx
    rules:
      - host: example.com
        http:
          paths:
            - path: /path
              pathType: Prefix
              backend:
                service:
                  name: example-service
                  port:
                    number: 80
    tls:
      - hosts:
          - example.com
        secretName: example-tls-secret
```
