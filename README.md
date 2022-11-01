[![Massdriver][logo]][website]

# k8s-timescale-db

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]


Deploy Timescale DB on a Kubernetes Cluster


---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle


<!-- COMPLIANCE:START -->

Security and compliance scanning of our bundles is performed using [Bridgecrew](https://www.bridgecrew.cloud/). Massdriver also offers security and compliance scanning of operational infrastructure configured and deployed using the platform.

| Benchmark | Description |
|--------|---------------|
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-timescale-db/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-timescale-db&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-timescale-db/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-timescale-db&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-timescale-db/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-timescale-db&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-timescale-db/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-timescale-db&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-timescale-db/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-timescale-db&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/k8s-timescale-db/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fk8s-timescale-db&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |

<!-- COMPLIANCE:END -->

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`database_configuration`** *(object)*
  - **`cpu_limit`** *(number)*: The amount of compute (in vCPUs) made available to your TimescaleDB deployment by kubernetes. Minimum: `0.5`. Maximum: `96`. Default: `1`.
  - **`data_volume_size`** *(integer)*: The size of the TimescaleDB's data storage. Minimum: `10`. Maximum: `1000`. Default: `10`.
  - **`delete_volumes_on_destroy`** *(boolean)*: If set to false and this bundle is destroyed, the volumes will be left behind. See operator guide for more information. Default: `False`.
  - **`memory_limit`** *(number)*: The amount of memory (in GiB) made available to your TimescaleDB deployment by kubernetes. Minimum: `0.5`. Maximum: `64`. Default: `4`.
- **`namespace`** *(string)*: Choose a namespace for Timescale DB.
## Examples

  ```json
  {
      "__name": "Development",
      "database_configuration": {
          "cpu_limit": 1,
          "data_volume_size": 10,
          "delete_volumes_on_destroy": true,
          "memory_limit": 2
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "database_configuration": {
          "cpu_limit": 4,
          "data_volume_size": 50,
          "delete_volumes_on_destroy": false,
          "memory_limit": 8
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`kubernetes_cluster`** *(object)*: Kubernetes cluster authentication and cloud-specific configuration. Cannot contain additional properties.
  - **`data`** *(object)*
    - **`authentication`** *(object)*
      - **`cluster`** *(object)*
        - **`certificate-authority-data`** *(string)*
        - **`server`** *(string)*
      - **`user`** *(object)*
        - **`token`** *(string)*
    - **`infrastructure`** *(object)*: Cloud specific Kubernetes configuration data.
      - **One of**
        - AWS EKS infrastructure config*object*: . Cannot contain additional properties.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`oidc_issuer_url`** *(string)*: An HTTPS endpoint URL.

            Examples:
            ```json
            "https://example.com/some/path"
            ```

            ```json
            "https://massdriver.cloud"
            ```

        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

        - GCP Infrastructure GRN*object*: Minimal GCP Infrastructure Config. Cannot contain additional properties.
          - **`grn`** *(string)*: GCP Resource Name (GRN).

            Examples:
            ```json
            "projects/my-project/global/networks/my-global-network"
            ```

            ```json
            "projects/my-project/regions/us-west2/subnetworks/my-subnetwork"
            ```

            ```json
            "projects/my-project/topics/my-pubsub-topic"
            ```

            ```json
            "projects/my-project/subscriptions/my-pubsub-subscription"
            ```

            ```json
            "projects/my-project/locations/us-west2/instances/my-redis-instance"
            ```

            ```json
            "projects/my-project/locations/us-west2/clusters/my-gke-cluster"
            ```

  - **`specs`** *(object)*
    - **`kubernetes`** *(object)*: Kubernetes distribution and version specifications.
      - **`cloud`** *(string)*: Must be one of: `['aws', 'gcp', 'azure']`.
      - **`distribution`** *(string)*: Must be one of: `['eks', 'gke', 'aks']`.
      - **`platform_version`** *(string)*
      - **`version`** *(string)*
<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`postgresql-authentication`** *(object)*: Authentication parameters for a PostgreSQL database. Cannot contain additional properties.
  - **`data`** *(object)*: Cannot contain additional properties.
    - **`authentication`** *(object)*
      - **`hostname`** *(string)*
      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: Cloud specific PostgreSQL configuration data.
      - **One of**
        - AWS Infrastructure ARN*object*: Minimal AWS Infrastructure Config. Cannot contain additional properties.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

        - GCP Infrastructure Name*object*: GCP Infrastructure Config For Resources With A Name Not A GRN. Cannot contain additional properties.
          - **`name`** *(string)*: Name Of GCP Resource.

            Examples:
            ```json
            "my-cloud-function"
            ```

            ```json
            "my-sql-instance"
            ```

        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

        - Kuberenetes infrastructure config*object*: . Cannot contain additional properties.
          - **`kubernetes_namespace`** *(string)*
          - **`kubernetes_service`** *(string)*
    - **`security`** *(object)*: TBD.
      - **Any of**
        - AWS Security information*object*: Informs downstream services of network and/or IAM policies. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Policies. Cannot contain additional properties.
            - **`^[a-z-/]+$`** *(object)*
              - **`policy_arn`** *(string)*: AWS IAM policy ARN.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

          - **`network`** *(object)*: AWS security group rules to inform downstream services of ports to open for communication. Cannot contain additional properties.
            - **`^[a-z-]+$`** *(object)*
              - **`arn`** *(string)*: Amazon Resource Name.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

              - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
              - **`protocol`** *(string)*: Must be one of: `['tcp', 'udp']`.
        - Security*object*: Azure Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Scopes. Cannot contain additional properties.
            - **`^[a-z/-]+$`** *(object)*
              - **`role`**: Azure Role.

                Examples:
                ```json
                "Storage Blob Data Reader"
                ```

              - **`scope`** *(string)*: Azure IAM Scope.
        - Security*object*: GCP Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Conditions. Cannot contain additional properties.
            - **`^[a-z-/]+$`** *(object)*
              - **`condition`** *(string)*: GCP IAM Condition.
              - **`role`**: GCP Role.

                Examples:
                ```json
                "roles/owner"
                ```

                ```json
                "roles/redis.editor"
                ```

                ```json
                "roles/storage.objectCreator"
                ```

                ```json
                "roles/storage.legacyObjectReader"
                ```

  - **`specs`** *(object)*: Cannot contain additional properties.
    - **`rdbms`** *(object)*: Common metadata for relational databases.
      - **`engine`** *(string)*: The type of database server.

        Examples:
        ```json
        "postgresql"
        ```

        ```json
        "mysql"
        ```

      - **`engine_version`** *(string)*: The cloud provider's database version.

        Examples:
        ```json
        "5.7.mysql_aurora.2.03.2"
        ```

      - **`version`** *(string)*: The database version. Default: ``.

        Examples:
        ```json
        "12.2"
        ```

        ```json
        "5.7"
        ```


      Examples:
      ```json
      {
          "engine": "postgresql",
          "engine_version": "10.14",
          "version": "10.14"
      }
      ```

      ```json
      {
          "engine": "mysql",
          "engine_version": "5.7.mysql_aurora.2.03.2",
          "version": "5.7"
      }
      ```

<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/k8s-timescale-db/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg
[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=k8s-timescale-db&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=k8s-timescale-db&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=k8s-timescale-db&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=k8s-timescale-db&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=k8s-timescale-db&utm_content=linkedin



[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/k8s-timescale-db.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/k8s-timescale-db/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/k8s-timescale-db.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/k8s-timescale-db/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/k8s-timescale-db.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/k8s-timescale-db/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/k8s-timescale-db.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/k8s-timescale-db/issues
[release_url]: https://github.com/massdriver-cloud/k8s-timescale-db/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/k8s-timescale-db.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/k8s-timescale-db.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/k8s-timescale-db/blob/main/LICENSE


[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=k8s-timescale-db&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=k8s-timescale-db&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
