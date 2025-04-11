variable "sg_name"{
  description = "security group name"
  type        = string
}

variable "sg_description"{
  description = "description of security group"
  type        = string
  default     = "default"
}

variable "vpc_id"{
  description = "ID of the VPC"
  type = string
}

variable "ingress_ports" {
  type = list(object({
    port   = number
    description = string
    }))
  default = []
}

variable "ingress_cidr"{
  description = "ingress cidr block"
  type        = string
  default     = ""
}

variable "ingress_protocol"{
  description = "ingress protocol"
  type        = string
  default     = ""
}

variable "egress_ports" {
  type = list(object({
    port   = number
    description = string
  }))
  default = []
}

variable "egress_cidr"{
  description = "egress cidr block"
  type        = string
  default     = ""
}

variable "egress_protocol"{
  description = "egress_protocol"
  type        = string
  default     = ""
}

variable "tags" {
  description = "tags for security group"
  type        = map
  default     = {}
}