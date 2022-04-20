#!/usr/bin/env bash

NODE_ID=$1

sudo bash -c "cat >/etc/vault.d/vault.hcl" << EOF
## Vault Configuration File ##

cluster_addr  = "https://192.168.13.3X:8201"
api_addr      = "https://192.168.13.3X:8200"
disable_mlock = true

listener "tcp" {
  tls_disable = 1
  address = "127.0.0.1:8200"
#  tls_cert_file = ""
#  tls_key_file  = ""
#  tls_min_version = ""
}

storage "raft" {
  path    = "/etc/vault.d"
  node_id = "node1"
  retry_join {
    leader_api_addr = "192.168.13.31:8200"
  }
  retry_join {
    leader_api_addr = "192.168.13.32:8200"
  }
  retry_join {
    leader_api_addr = "192.168.13.33:8200"
  }
}
plugin_directory = "/etc/vault.d/plugin"
ui=true
EOF

echo "sed without -i"
sed "s/X/$1/g" "/etc/vault.d/vault.hcl"
echo "sed with-i"
sed -i "s/X/$1/g" "/etc/vault.d/vault.hcl"

sudo chmod 777 /etc/vault.d