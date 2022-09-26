source "qemu" "freebsd" {
  boot_command            = ["<esc><wait>", "boot -s<enter>", "<wait10s>", "/bin/sh<enter><wait>", "mdmfs -s 100m md /tmp<enter><wait>", "dhclient -l /tmp/dhclient.lease.re0 re0<enter><wait5>", "fetch -o /tmp/installerconfig http://{{ .HTTPIP }}:{{ .HTTPPort }}/installerconfig<enter><wait5>", "FILESYSTEM=${var.filesystem}<enter>", "export FILESYSTEM<enter>", "RC_CONF_FILE=${var.rc_conf_file}<enter>", "export RC_CONF_FILE<enter>", "bsdinstall script /tmp/installerconfig<enter>"]
  boot_wait         = "3s"
  cpus              = "${var.cpus}"
  disk_discard      = "unmap"
  disk_interface    = "ide"
  disk_size         = "${var.disk_size}"
  format            = "qcow2"
  headless          = true
  http_directory    = "http"
  http_port_max     = 8181
  http_port_min     = 8181
  iso_checksum      = "1eb83d5afeec581181fee90273920424fb4239e6d80a48ffcc1e50ace1c8c218e33b8d2d289560ed6d10a46f882d6df7c2d13d4a43bfd8b48370eb1ba81bb5f6"
  iso_url           = "https://download.freebsd.org/snapshots/amd64/amd64/ISO-IMAGES/14.0/FreeBSD-14.0-CURRENT-amd64-20220923-00d8a28f19b-258155-disc1.iso"
  memory            = "${var.memory}"
  net_device        = "rtl8139"
  qemuargs          = [
    ["-usb",""],
    ["-display","none"],
    ["-device", "virtio-serial"],
    ["-device", "virtio-rng-pci"],
  ]
  shutdown_command  = "poweroff"
  ssh_password      = "vagrant"
  ssh_timeout       = "1000s"
  ssh_port          = 22
  ssh_username      = "root"
  use_default_display = true
  vm_name           = "box"
  vnc_port_max      = "5959"
  vnc_port_min      = "5959"
}

build {
  sources = ["source.qemu.freebsd"]
    provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; env {{ .Vars }} {{ .Path }}"
    scripts         = ["scripts/update.sh","scripts/vagrant.sh","scripts/cleanup.sh","scripts/ansible.sh"]
    }
    post-processor "vagrant" {
    vagrantfile_template = "vagrantfile.tpl"
  }
  }

