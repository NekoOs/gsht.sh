# Deployment Automation Example

This example demonstrates how to automate the deployment of an application using Bash scripts organized in a modular
structure.

## Requirements

- **gsht**: This tool is required to generate the `bin/deploy.sh` script. You can find installation instructions in
  the [official gsht documentation](https://github.com/NekoOs/gsht.sh?tab=readme-ov-file#installation-and-update-script).

## Generating the `bin/deploy.sh` Script

To generate the `bin/deploy.sh` file from the main deployment script located at `deploy/scripts/run_deploy.sh`, use the
following command:

```bash
gsht deploy/scripts/run_deploy.sh --output bin/deploy.sh
```
