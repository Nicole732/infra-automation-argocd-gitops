variable aws_region {
  default = "eu-west-1"
}

variable name {
    default = "myapp-eks"
}

variable k8s_version {
    default = "1.28"
}

variable vpc_cidr_block {
    default = "10.0.0.0/16"
}
variable private_subnet_cidr_blocks {
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable public_subnet_cidr_blocks {
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable tags {
    default = {
        App  = "eks-devsecops"
    }
}

variable user_for_admin_role {}
variable user_for_dev_role {}

variable gitops_url {}
variable gitops_username {}
variable gitops_password {}