variable "environment" {
  type        = string
  description = "Name of environment"
}

variable "kubeconfig_path" {
  type        = string
  description = "Path to kuberetes config file"
  default     = "~/.kube/config"
}

variable "context" {
  type        = string
  description = "Name of kubectl context"
  default     = "kind-development"
}
