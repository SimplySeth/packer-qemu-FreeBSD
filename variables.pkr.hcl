variable "cpus" {
  type    = number
  default = 1
}

variable "disk_size" {
  type    = number
  default = 16384
}


variable "filesystem" {
  type    = string
  default = "zfs"
}

variable "memory" {
  type    = number
  default = 1024
}
variable "rc_conf_file" {
  type = string
  default = ""
}

