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

```

