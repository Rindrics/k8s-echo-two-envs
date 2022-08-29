variable "environment" {
  type        = string
  description = "Name of environment such as 'production'"
  default     = "production"
}

variable "host_ingress_port_http" {
  type        = number
  description = "HTTP port number to use ingress"
  default     = 80
}

variable "host_ingress_port_ssh" {
  type        = number
  description = "SSH port number to use ingress"
  default     = 443
}
