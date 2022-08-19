# k8s-timescale-db

Deploy Timescale DB on a Kubernetes Cluster

## Development

### Enabling Pre-commit

This repo includes Terraform pre-commit hooks.

[Install precommmit](https://pre-commit.com/index.html#installation) on your system.

```shell
git init
pre-commit install
```

Terraform hooks will now be run on each commit.

### GitHub Action for Publishing to Massdriver

A github workflow for publishing has been configured in `.github/workflows/publish.yaml`.

You'll need to set your `MASSDRIVER_API_KEY` in GitHub secrets.

### Configuring a bundle

`massdriver.yaml` TBD - walk through of fields & purpose (params, connections, artifacts)

### Building a bundle

Variables files can be generated for your bundle from your `massdriver.yaml` file by running

```shell
mass bundle build
```

Two development `tfvars` files are provided for setting `params` and `connections`:

```shell
cd src
terraform init
terraform plan -var-file=./dev.connections.tfvars.json -var-file=./dev.params.tfvars.json
```

### Developing a bundle

`md_metadata` - naming convention prefix, tags etc

### Misc

#### Other files

- `operator.mdx` TBD
- `schema.stories.json` TBD
# JSON Schema

*Deploy Timescale DB on a Kubernetes Cluster*

## Properties

- **`database_configuration`** *(object)*: Cannot contain additional properties.
  - **`cpu_limit`** *(number)*: The amount of compute (in vCPUs) made available to your TimescaleDB deployment by kubernetes. Minimum: `0.5`. Maximum: `96`. Default: `1`.
  - **`data_volume_size`** *(integer)*: The size of the TimescaleDB's data storage. Minimum: `10`. Maximum: `1000`. Default: `10`.
  - **`memory_limit`** *(number)*: The ammount of memory (in GiB) made available to your TimescaleDB deployment by kubernetes. Minimum: `0.5`. Maximum: `64`. Default: `4`.
- **`namespace`** *(string)*: Choose a namespace for Timescale DB.
## Examples

  ```json
  {
      "__name": "Development",
      "database_configuration": {
          "cpu_limit": 1,
          "memory_limit": 2,
          "storage": 10
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "database_configuration": {
          "cpu_limit": 4,
          "memory_limit": 8,
          "storage": 50
      }
  }
  ```

