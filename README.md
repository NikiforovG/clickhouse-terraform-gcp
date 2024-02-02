# clickhouse-terraform-gcp

This repository contains Terraform scripts for automating the infrastructure deployment for ClickHouse on the Google
Cloud Platform (GCP).

## Features

- Automates the creation of a Virtual Machine (VM) on the Google Compute Engine (GCE).
- Sets up an additional persistent SSD for data storage.
- Configures the network settings to allow traffic through the ClickHouse port.
- Assigns a static IP to the VM for consistent access.

## Prerequisites

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) Installed
- [GCP Account](https://cloud.google.com/compute/docs/quickstart)

## Usage

1. Clone the repository to your local system.
    ```
    git clone git@github.com:NikiforovG/clickhouse-terraform-gcp.git
    ```

2. Move to the directory containing the Terraform scripts.
    ```
    cd clickhouse-terraform-gcp
    ```

3. Initialize your Terraform workspace, which will download the provider.
    ```
    terraform init
    ```

4. Now, validate your configuration. If it's valid, the command won't return any errors.

   From this moment make sure you have `GOOGLE_CREDENTIALS` environment variable defined with your service account json
   key.
    ```
    terraform validate
    ```

5. Now, let's plan our deployment.
    ```
    terraform plan
    ```

6. Once everything is ready, apply your configuration.
    ```
    terraform apply
    ```

## Acknowledgments

- [Google Cloud Platform](https://cloud.google.com/)
- [Terraform](https://www.terraform.io/)
- [ClickHouse](https://clickhouse.tech/)