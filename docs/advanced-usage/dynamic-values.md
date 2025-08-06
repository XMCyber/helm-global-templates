# Dynamic Values

We tackle a common problem in our charts, where we need to generate values dynamically based on the values provided to the chart.
Typically, we could use a values file to define the values, but sometimes we need to generate values based on the provided values.
We could use a `tpl` functions to generate the values, but this can get messy and hard to maintain.

We solved this problem by using a `dynamic-values`, basically a utilily function that allows us to "inject" global values into other values.

### Usage

The syntax for injecting a global value is `{{ global.path_to_value }}`, you can also use nested values like `{{ global.path.to.value }}`.

> Note: You can't use dynamic-values in any resource, if the resource or property is not supported, open an issue or a pull request to add support for it.

### Example

```yaml
# Dynamic values has to be defined in the global scope
global:
  key: injected
  db:
    host: db.example.com
    port: 5432

deployments:
  - name: app
    namespace: default
    containers:
      - name: app
        image:
          registry: docker.io
          repository: busybox
          tag: latest
        ports:
          - containerPort: 8080
        env:
          - name: INJECTED_WORD
            value: "This is going to be {{ global.key }} here" # Inject the key here
          - name: DB_HOST
            value: "{{ global.db.host }}" # You can also use nested values
          - name: DB_PORT 
            value: "{{ global.db.port }}"
```

In the example above, the value of `INJECTED_WORD` will be `This is going to be injected here`.
