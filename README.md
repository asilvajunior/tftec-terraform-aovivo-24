<p align="center">
<img src="assets/images/unicast_logo.png">
</p>

This repository is part of the presentation **"TFTEC AO VIVO EM SÃO PAULO 2024"**. For more information about the event, please visit [**here**](https://www.tftec.com.br/tftecaovivo-2024/).

# Pre-requisites

1. Azure Cloud Subscription
2. Course Github Repositories
3. Azure CLI
4. Terraform

## Step-01: Azure Cloud Subscription

- [Azure Free Account](https://azure.microsoft.com/en-in/free/)
- 200 dollar credit for first 30 days

## Step-02: Fork Course Github Repositories

- [Azure Kubernetes Service with Azure DevOps and Terraform](https://github.com/asilvajunior/tftec-terraform-aovivo-24)

>NOTE: If you do not have Azure CLI and Terraform installed on your machine, follow these steps:

## Step-03: Install Tools

**Linux Way**

1 - Install Azure CLI

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

2 - Install Terraform

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

3 - Verify the installations

```bash
az version
terraform version
````

--- 

**Windows Way**

1 - Install Azure CLI (Download and install)

```
https://learn.microsoft.com/pt-br/cli/azure/install-azure-cli
```

2 - Install Terraform (Chocolatey)
Install Chocolatey (if it is not already installed). Open PowerShell as Administrator and run the command:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
``` 

Install Terraform with Chocolatey:

```powershell
choco install terraform -y
```

3 - Verify the installations

```powershell
az version
terraform version
```

---

**Mac Way**

1 - Install Brew (if it is not already installed)
Open terminal and run the command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
````

2 - Install Azure CLI

```bash
brew update && brew install azure-cli
```

2 - Install Terraform

```bash
brew install terraform
```

```bash
az version
terraform version
````

---

- **Important Note:** Please access this repository and FORK it and use them during the course.

## :memo: License

This project is under [MIT License](./LICENSE).
