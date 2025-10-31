module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.3.2"

  name               = local.cluster_name
  kubernetes_version = "1.31"

  vpc_id                       = module.vpc.vpc_id
  subnet_ids                   = module.vpc.private_subnets
  endpoint_public_access       = true
  endpoint_private_access      = true
  endpoint_public_access_cidrs = ["0.0.0.0/0"]
  enable_irsa                  = true

  eks_managed_node_groups = {
    one = {
      name           = "node-group-1"
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
      subnet_ids   = module.vpc.private_subnets
    }

    two = {
      name           = "node-group-2"
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
      subnet_ids   = module.vpc.private_subnets
    }
  }
}
