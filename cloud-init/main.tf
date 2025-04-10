terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.7.1"
    }
  }
}

provider "libvirt" {
  uri = "qemu+ssh://badger@saltmine.local/system?keyfile=/Users/badger/.ssh/pubkeys/bluetufa.pub"
}

resource "libvirt_volume" "fedora_qcow" {
  name   = "Fedora-Cloud-41.qcow2"
  pool   = "default"
  source = "https://download.fedoraproject.org/pub/fedora/linux/releases/41/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-41-1.4.x86_64.qcow2"
  format = "qcow2"
}

provisioner "local-exec" {
  command = <<EOT
    sudo chown libvirt-qemu:kvm /var/lib/libvirt/images/Fedora-Cloud-41.qcow2
    sudo chmod 0644 /var/lib/libvirt/images/Fedora-Cloud-41.qcow2
    sudo restorecon -v /var/lib/libvirt/images/Fedora-Cloud-41.qcow2 || true
  EOT
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name           = "cloudinit.iso"
  user_data      = file("${path.module}/user-data.yml")
  pool           = "default"
}

resource "libvirt_domain" "fedora_vm" {
  name   = "fedora-cloudinit"
  memory = 2048
  vcpu   = 2

  disk {
    volume_id = libvirt_volume.fedora_qcow.id
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }
}
