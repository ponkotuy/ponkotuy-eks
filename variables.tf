variable "eks_version" {
  type = string
  default = "1.14"
}

variable "cluster_name" {
  type = string
  default = "ponkotuy"
}

variable "project_name" {
  type = string
  default = "ponkotuy-eks"
}

variable "instance_size" {
  type = string
  default = "t3.small"
}

variable "instance_disk_size" {
  type = number
  default = 20
}
