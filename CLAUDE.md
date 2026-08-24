# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Terraform sandbox that simulates provisioning a "virtual developer box" without any real cloud provider. The only real provider is `hashicorp/random`; the box and its data disk are modeled with built-in `terraform_data` resources that just carry the rendered spec in state. Requires Terraform >= 1.15.0.

## Commands

```sh
terraform init        # install providers (pinned via .terraform.lock.hcl)
terraform plan        # preview changes
terraform apply       # apply (safe: creates no real infrastructure)
terraform validate    # check configuration
terraform fmt         # format .tf files
```

There are no tests or linters beyond `terraform validate` and `terraform fmt`.

## Structure

The entire configuration is driven by a single object variable, `dev_box` (variables.tf). Its numeric fields (`cpu`, `memory_gb`, `disk_gb`) are deliberately typed as strings and converted with `tonumber()` in main.tf. Values are supplied via `terraform.tfvars`.

In main.tf, `random_pet.hostname` generates the hostname, `terraform_data.dev_box` is the "VM" (with `triggers_replace` on os/cpu/memory/disk so hardware changes force re-creation), and `terraform_data.data_disk` attaches to it via its output. Outputs in outputs.tf expose the hostname and both rendered specs.

State files (`*.tfstate`) are gitignored but present locally — an apply has been run here before.
