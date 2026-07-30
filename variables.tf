variable "cidr_block"{
    type= string
}

variable "project"{
    type= string
}

variable "environment"{
    type= string
}

variable "vpc_tags"{
    type= map
    default= {}
}

variable "ig"{
    type= map
    default= {}
}

variable "public_subnet"{
    type=list
}

variable "public_subnet_tags"{
    type= map
    default={}
}

variable "private_subnet"{
    type=list
}

variable "private_subnet_tags"{
    type= map
    default={}
}

variable "database_subnet"{
    type=list
}

variable "database_subnet_tags"{
    type= map
    default={}
}

variable "public_route_table"{
    type= map
    default={}
}

variable "private_route_table"{
    type= map
    default={}
}

variable "database_route_table"{
    type= map
    default={}
}

variable "nat_tags"{
    type= map
    default={}
}

variable "elastic_ipe"{
    type= map
    default={}
}

variable "peering"{
    type= map
    default={}
}

variable "is_peering_required" {
  type = bool
  default = true
}