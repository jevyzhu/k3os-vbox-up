variable headless {
  default = false
}

variable boot_wait {
  default = "3s"
}

variable iso_url {
  default = "https://github.com/rancher/k3os/releases/download/v0.11.1/k3os-amd64.iso"
}

variable iso_checksum {
  default = "md5:ba4043afc8bbda990d696be730449c1d"
}


variable  ssh_pkf {
}

variable vm_name {
  default = "jevy-demo"
}

variable config {
}

