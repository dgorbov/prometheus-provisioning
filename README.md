# prometheus-provisioning
Provision infrastructure and software to run Prometheus and Grafana.

## Initial plan
- Use `Terraform` to provision infrastructure for Prometheus and Grafana depoyments.
- Use `Ansible` to provision Prometheus and Grafana software to run solution.
- Store here all configuration for Prometheus and Grafana software.
- This solution going to be deployed inside our AWS perimeter.

## Setup
1. check your aws creds. `[default]` profile is used. If you want different set var `aws_profile` in `terraform.tfvars` to ovveride.
2. terraform init
3. cd ansible
4. ansible-playbook installation.yml
