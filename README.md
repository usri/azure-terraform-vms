# Azure VM Demo

This sample repo shows various capabilities of terraform to create dynamic infrastructure using lists, maps, loops and more applied to VMs, Networking and some other resources as well.

It creates:

- A new Resource Group.
- A Windows VM.
- A CentOs VM.
- An Ubuntu VM.
- A RedHat VM.
- A VNet with multiple subnets that could be defined in multiple ways (lists, maps, etc.).
- Security Groups.
- Storage Account.

## Project Structure

This project has the following files which make them easy to reuse, add or remove.

```ssh
├── LICENSE
├── README.md
├── WindowsVMVar.tf
├── centOSVM.tf
├── centOSVMvar.tf
├── cloud-init-jenkins.yaml
├── cloud-init.yaml
├── main.tf
├── mainVar.tf
├── networking.tf
├── networkingVar.tf
├── outputs.tf
├── redHatVM.tf
├── redHatVMVar.tf
├── security.tf
├── securityVar.tf
├── storageVar.tf
├── storage.tf
├── ubuntuVM.tf
├── ubuntuVMVar.tf
├── vmVar.tf
└── windowsVM.tf
```

## Pre-requisites

It is assumed that you have azure CLI installed and configured.
More information on this topic [here](https://docs.microsoft.com/en-us/azure/terraform/terraform-overview). I recommend using a Service Principal with a certificate for authentication specially if you are using this as part of your Ci/CD pipeline.

### versions

- Terraform 0.12.7
- AzureRM provider 1.33.1
- Azure CLI 2.17.1

## VM Authentication

Linux uses key based authentication and it assumes you already have a key and you can configure the path using the _sshKeyPath_ variable in _`vmVar.tf`_ . You can create one using this command:

```ssh
ssh-keygen -t rsa -b 4096 -m PEM -C vm@mydomain.com -f ~/.ssh/vm_ssh
```

and set it using this approach:

```ssh
export TF_VAR_sshKeyPath=`cat ~/.ssh/vm_ssh.pub`
```

Linux VMs also show integration with [cloud init](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/using-cloud-init) to customize the VM by installing or making some configurations at provisioning time. You can customize this behavior by modifying these files:

- cloud-init-jenkins.yaml
- cloud-init.yaml

Windows authentication uses user name and password. It is not recommended setting these values in terraform scripts. You can set them as Environment variables. More information about this approach can be found [here](https://www.terraform.io/docs/configuration/variables.html#environment-variables).
These variables _vmUserName_ and _password_ that you should set up using this approach and they are also located in _`vmVar.tf`_ :

```ssh
export TF_VAR_vmUserName={{VMUSER}}
export TF_VAR_password={{VMPASSWORD}}
```

Starting with [terraform 0.14](https://www.hashicorp.com/blog/announcing-hashicorp-terraform-0-14-general-availability) you can also set all these credentials as sensitive. More information [here.](https://www.terraform.io/docs/configuration/expressions/references.html#sensitive-resource-attributes)

## Usage

Just run these commands to initialize terraform, get a plan and approve it to apply it.

```ssh
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
```

I also recommend using a remote state instead of a local one. You can change this configuration in _`main.tf`_

You can create a free Terraform Cloud account [here](https://app.terraform.io).

## Clean resources

It will destroy everything that was created.

```ssh
terraform destroy --force
```

## Caution

Be aware that by running this script your account might get billed.

## Authors

- Marcelo Zambrana
