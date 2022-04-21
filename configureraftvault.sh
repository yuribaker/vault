#!/usr/bin/env bash

NODE_ID=$1

sudo bash -c "cat >/etc/vault.d/vault.hcl" << EOF
## Vault Configuration File ##

disable_cache           = true
disable_mlock           = true
ui                      = true

listener "tcp" {
  address              = "0.0.0.0:8200"
  cluster_addr         = "0.0.0.0:8201"
  tls_disable = 1
#  tls_cert_file = ""
#  tls_key_file  = ""
#  tls_min_version = ""
}

storage "raft" {
  path    = "/etc/vault.d"
  node_id = "node1"
  retry_join {
    leader_api_addr = "http://192.168.13.31:8200"
  }
  retry_join {
    leader_api_addr = "http://192.168.13.32:8200"
  }
  retry_join {
    leader_api_addr = "http//192.168.13.33:8200"
  }
}
plugin_directory = "/etc/vault.d/plugin"
ui=true
cluster_addr            = "http://192.168.13.31:8201"
api_addr                = "http://192.168.13.31:8200"
cluster_name            = "vault"
EOF

sudo chmod 777 /etc/vault.d

echo "sed without -i"
sed "s/X/$1/g" "/etc/vault.d/vault.hcl"
echo "sed with-i"
sed -i "s/X/$1/g" "/etc/vault.d/vault.hcl"
