terraform {
  required_version = ">= 1.5.0"
  required_providers {
    vagrant = {
      source  = "hashicorp/vagrant"
      version = "~> 0.4"
    }
  }
}

provider "vagrant" {}

# Variables
variable "vm_count" {
  type    = number
  default = 2
}

variable "vm_name_prefix" {
  type    = string
  default = "wpvm"
}

variable "box_name" {
  type    = string
  default = "ubuntu/jammy64"
}

variable "private_ip_base" {
  type    = string
  default = "192.168.50"
}

variable "vm_memory" {
  type    = number
  default = 2048
}

variable "vm_cpus" {
  type    = number
  default = 2
}

# VMs
resource "vagrant_vm" "vm" {
  count = var.vm_count

  name = "${var.vm_name_prefix}-${count.index + 1}"
  box  = var.box_name

  network {
    type = "private_network"
    ip   = "${var.private_ip_base}.${10 + count.index}"
  }
  network {
    type         = "forwarded_port"
    guest        = 22
    host         = 2222 + count.index
    auto_correct = true
  }

  provider_settings = {
    provider = "virtualbox"
    memory   = var.vm_memory
    cpus     = var.vm_cpus
  }

  provision {
    type   = "shell"
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y python3 python3-apt"
    ]
  }
}
