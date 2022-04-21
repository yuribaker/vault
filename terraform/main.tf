provider "aws" {
  region = "us-east-1"
}

module "vault" {
  source = "github.com/binlab/terraform-aws-vault-ha-raft?ref=v0.1.8"

  cluster_name       = "vault-ha"
  node_instance_type = "t3a.small"
  autounseal         = true
  nat_enabled        = true
}

output "cluster_url" {
  value = module.vault_ha.cluster_url
}
