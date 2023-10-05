resource "proxmox_vm_qemu" "srv_demo_1" {
        name = "srv-demo-1"
        desc = "Ubuntu-Server"
        target_node = "hpeproxmox"
        sshkeys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6mJVM9pHqEbRkhT6PUh0wEzcJagRUZlPD7/xwvIzGdwkj7hv/fi8oQEQou5dYg9TeBPM7oYADD1sfZ2SVQkukEhdgmuVJ88ZwsqJcfekgvuK3KcRIVnvR/r2oKBDqG/B0YSxxoU8DwNngroUYjAfyOU8a96Tr/b27PggExr2HusAFZoabTlo2XSXsjRMvg4VYaMU5nn74NKzScxjWCB0KPeBbjSyIfWAR/bLzvh1d3CoU4Al83ErWuT6u+378AO/gq5mUP5xQNT+pFO2/YgAOZ3LgOKnWGfCYu3pze7Tc/sPyC8Wkithxck/O8oyZI65jXKp9GFcw15pn6iSPiqh5dXuVLSGS1K88OxBEDN4Ghl37yfgCIvrO9AZRrM8ylxrO0VdyUbNFjRTkXfVN5sTqXER2MCPPuu9rwsutUGKfYANhPeLQYpeoSBT5hqOFaIJRBnnvglo3ZaP+3Pkl+SKXuTUzZcRdBR48xKkW48JfqeHVYeEYNYwnKE2t0p/wLVE= ubuntu@ubuntu"
        agent = 1
        clone = "ubuntu2204-ci"
        qemu_os = "l26"
        # this l26 is a small l like linux
        cores = 2
        sockets = 1
        cpu = "host"
        memory = 8096
        scsihw = "virtio-scsi-pci"

        vga {
                type = "std"
        }

        disk {
                storage = "local-lvm"
                type = "scsi"
                size = "83212M"
                discard = "on"
                ssd = "1"
        }

        network {
                bridge = "vmbr0"
                model = "virtio"
        }

        ## muss dem Template matchen

        os_type = "cloud-init"
        ipconfig0 = "ip=dhcp"
        nameserver = "172.16.0.1"
        ciuser = "ubuntu"
}
