# Terraform Proxmox

## API Token erstellen in Proxmox

```
Zuerst muss in Proxmox VE ein API-Token erstellt werden, dies passiert auf Datacenter Ebene unter dem Punkt Permissions -> API-Tokens -> Add. Wichtig ist, dass die Privilege Separation für diesen Funktionstest auf No gestellt ist, bzw. Sie bei der Erstellung des API Tokens den Haken nicht setzen. Bitte kopieren Sie sich den API-Key nach der Erstellung, da dieser danach nicht mehr nachträglich eingesehen werden kann. In unserem Fall ergeben sich dann folgende Credentials:

root@pam!terraform2
b057aea1-a092-49c3-b530-a53fd9e6fccc

```

## Terraform Provider erstellen

vi provider.tf 
```
terraform {
        required_providers {
                proxmox = {
                        source = "telmate/proxmox"
                        version = "2.9.14"
                }
        }
}

variable "proxmox_api_url" {
        type = string
}

variable "proxmox_api_token_id" {
        type = string
        sensitive = true
}

variable "proxmox_api_token_secret" {
        type =  string
        sensitive = true
}

provider "proxmox" {

        pm_api_url= var.proxmox_api_url
        pm_api_token_id = var.proxmox_api_token_id
        pm_api_token_secret = var.proxmox_api_token_secret
        pm_tls_insecure = true
}
```


## API Credentials hinterlegen

vi credentials.auto.tfvars
```

```


