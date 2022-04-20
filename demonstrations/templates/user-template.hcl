  ##  user-templated.hcl

  ##  Grant permissions on a path that's specific to a user name.
path "user-kv/data/{{identity.entity.name}}/*" {
    capabilities = [ "create", "update", "read", "delete", "list" ]
}

# For Web UI usage
path "user-kv/metadata" {
  capabilities = ["list"]
}
