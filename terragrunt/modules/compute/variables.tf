variable "tenancy_ocid" {
  type        = string
  description = "Tenancy OCID"
}

variable "environment" {
  type        = string
  description = "Environment where the instance will be deployed"
}

variable "instance_shape" {
  type        = string
  description = "Shape of the instance"
  default     = "VM.Standard.E2.1.Micro"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key"
  default     = "~/.ssh/id_rsa_free_oci_instance.pub"
}

variable "vcn_cidr" {
  type        = string
  description = "CIDR block for the VCN"
  default     = "10.0.1.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the Subnet"
  default     = "10.0.1.0/24"
}