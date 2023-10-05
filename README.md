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
proxmox_api_url = "https://172.16.0.161:8006/api2/json"
proxmox_api_token_id = "root@pam!terraform"
proxmox_api_token_secret = "b057aea1-a092-49c3-b530-a53fd9e6fccc"
```


## Cloudinit Image erstellen (Ubuntu 22.04) in Proxmox

```
cd /var/lib/vz/template/iso/
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
apt update -y && apt install libguestfs-tools -y
virt-customize -a cd /var/lib/vz/template/iso/jammy-server-cloudimg-amd64.img --install qemu-guest-agent
virt-customize -a cd /var/lib/vz/template/iso/jammy-server-cloudimg-amd64.img --root-password password:relation
virt-customize -a cd /var/lib/vz/template/iso/jammy-server-cloudimg-amd64.img --run-command "echo -n > /etc/machine-id"
```

## Template erstellen (Ubuntu 22.04) in Proxmox

Aus dem Cloud-Image jammy-server-cloudimg-amd64.img wird nun ein VM-Template erzeugt
```
qm create 9000 --name "ubuntu2204-ci" --memory 8096 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 /var/lib/vz/template/iso/jammy-server-cloudimg-amd64.img local-lvm
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --serial0 socket --vga serial0
qm set 9000 --agent enabled=1
qm resize 9000 scsi0 +50G
qm template 9000
```

##

vi srvdemo1.tf
```

```



