# hcloud.pkr.hcl

packer {
  required_plugins {
    hcloud = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/hcloud"
    }
  }
}

variable "talos_version" {
  type    = string
  default = "v1.11.3"
}

variable "build_timestamp" {
  type        = string
  description = "Build timestamp to ensure unique snapshot names"
  default     = ""
}

locals {
  image         = "https://github.com/siderolabs/talos/releases/download/${var.talos_version}/hcloud-amd64.raw.xz"
  snapshot_name = var.build_timestamp != "" ? "talos-${var.talos_version}-${var.build_timestamp}" : "talos-${var.talos_version}"
}

source "hcloud" "talos" {
  rescue       = "linux64"
  image        = "debian-13"
  location     = "ash"
  server_type  = "cpx11"
  ssh_username = "root"

  snapshot_name = local.snapshot_name
  snapshot_labels = {
    type    = "infra",
    os      = "talos",
    version = "${var.talos_version}",
  }
}

build {
  sources = ["source.hcloud.talos"]

  provisioner "shell" {
    inline = [
      "apt-get install -y wget",
      "wget -O /tmp/talos.raw.xz ${local.image}",
      "xz -d -c /tmp/talos.raw.xz | dd of=/dev/sda && sync",
    ]
  }
}