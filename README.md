# k8s-timescale-db

Deploy [Timescale DB](https://www.timescale.com/) an open source plugin built ontop of Postgres for timeseries analysis on a Kubernetes Cluster

## What Is A Bundle  

Bundles are the basic building blocks of infrastructure, applications, and architectures in Massdriver. They are composed of Terraform modules or Helm charts. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Developing  

### How To Develop A Bundle

To learn how to develop a bundle for Massdriver, check out our [bundle docs](https://docs.massdriver.cloud/bundles/development).

### Contribution guidelines

So you're interested in contributing to Massdriver Bundles?  Please refer to Massdriver's overall
[contribution guidelines](https://docs.massdriver.cloud/bundles/contributing) to find out how you
can help with existing bundles or open source your own bundle.


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

