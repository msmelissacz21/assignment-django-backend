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

# ssh
If you want to ssh into the ec2 instance after it is deployed do the following
```bash
cd terraform
terraform output private_key
```
- copy the private key into a file called ec2_keypair.pem
- run the following in the same directory as the ec2_keypair.pem
```bash
chmod 400 "ec2_keypair.pem"
ssh -i "ec2_keypair.pem" ubuntu@<your-instances-public-DNS>
```