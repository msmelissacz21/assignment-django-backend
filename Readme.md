## Deployment
Currently infrastructure needs to be destroyed on subsequent deployments until logic is added to re-provision the ec2 instance.

Requirements
- install terraform
- install aws cli
- update your ima in main.tf to reflect your ec2 ubuntu ima

To deploy run the following commands
```bash
# When setting profile name it aws-cli-user, or update main.tf to match your profile name
aws sso configure 
cd terraform
terraform init
terraform destroy
terraform apply
```