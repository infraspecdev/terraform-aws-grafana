<!-- BEGIN_TF_DOCS -->
# Terraform Module Template

This repository serves as a template for creating Terraform modules. It provides a structured approach to organizing and maintaining Terraform code, along with examples and best practices.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Examples](#examples)
- [Module Structure](#module-structure)

## Prerequisites

Before you begin, ensure you have met the following requirements:

1. [install terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2. [install pre-commit](https://pre-commit.com/#install)
3. configure pre-commit: `pre-commit install`
4. install required tools
   - [tflint](https://github.com/terraform-linters/tflint)
   - [terraform-docs](https://github.com/terraform-docs/terraform-docs)

## Usage

To use this template, clone the repository and customize it according to your module's requirements. Below is a quick start guide:

1. **Clone the repository:**

   ```sh
   git clone https://github.com/your-username/terraform-module-template.git
   cd terraform-module-template
   ```
2. **Customize the module:**

   - Update `main.tf`, `variables.tf`, `outputs.tf`, and `versions.tf` files as needed.
   - Add your own resources and logic.
3. **Run Terraform commands:**

   ```sh
   terraform init
   terraform plan
   terraform apply
   ```

## Examples

This repository includes example configurations to help you understand how to use the module:

- **Complete Example:** Located in `examples/complete`

  - Demonstrates a full-featured usage of the module.

  ```sh
  cd examples/complete
  terraform init
  terraform apply
  ```
- **Minimal Example:** Located in `examples/minimal`

  - Shows a minimal configuration for using the module.

  ```sh
  cd examples/minimal
  terraform init
  terraform apply
  ```

## Module Structure

The repository is organized as follows:

```plaintext
.
├── .editorconfig
├── examples
│   ├── complete
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── provider.tf
│   │   ├── README.md
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── minimal
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       ├── README.md
│       ├── variables.tf
│       └── versions.tf
├── .github
│   └── workflows
│       ├── documentation.yaml
│       ├── pre-commit.yaml
│       └── pr-title.yaml
├── .gitignore
├── main.tf
├── modules
│   └── sample-resource
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── version.tf
├── outputs.tf
├── .pre-commit-config.yaml
├── README.md
├── .terraform-docs.yml
├── tests
│   ├── examples_minimal.tftest.hcl
│   └── unit_tests.tftest.hcl
├── .tflint.hcl
├── variables.tf
└── versions.tf
```

## Reference [Getoutline](https://infraspec.getoutline.com/doc/terraform-Xkko7xHwM5) Document for Conventions to follow in your module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.4 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
