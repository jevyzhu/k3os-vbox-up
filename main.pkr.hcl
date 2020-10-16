source virtualbox-iso myk3os {
    guest_os_type = "Linux_64"
    boot_wait = var.boot_wait
    headless = var.headless
    vm_name = var.vm_name
    memory = 1024
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    ssh_username = "rancher" 
    ssh_private_key_file = var.ssh_pkf
    http_directory = "."
    shutdown_command = "echo 'rancher' | sudo poweroff"
    boot_command = [
        "<down>e",
        "<down><down><down><down><down><down><end>",
	" k3os.mode=install k3os.fallback_mode=install",
	" k3os.install.silent=true k3os.install.device=/dev/sda", 
	" k3os.install.config_url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.config}",
	"<f10>",
    ]
    vboxmanage = [
        ["setextradata", "{{.Name}}",  "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", "0"],
        ["modifyvm", "{{.Name}}", "--rtcuseutc", "on"],
        ["modifyvm", "{{.Name}}", "--nic2", "hostonly"],
        ["modifyvm", "{{.Name}}", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    ]
}

build {
  sources = ["sources.virtualbox-iso.myk3os"]
  post-processor vagrant {
      output = "${var.vm_name}.box"
  }
}
