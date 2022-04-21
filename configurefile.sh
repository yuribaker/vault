#!/usr/bin/env bash

sudo bash -c "cat >/etc/vault.d/vault.hcl" << EOF
## Vault Configuration File ##

disable_cache           = true
disable_mlock           = true
ui                      = true

listener "tcp" {
  address              = "0.0.0.0:8200"
  tls_disable = 1
}

storage "file" {
  path = "/tmp/vault/data"
}

#plugin_directory = "/etc/vault.d/plugin"'
EOF


