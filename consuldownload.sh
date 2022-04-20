release="$(curl -s https://releases.hashicorp.com/consul/index.json|jq -r '.versions[].version'|grep -v 'ent\|rc\|beta'|tail -n 1)"
#release="$(curl -s https://releases.hashicorp.com/consul/index.json|jq -r '.versions[].version'|tail -n 1)"
download="https://releases.hashicorp.com/consul/1.3.0/consul_1.3.0_linux_amd64.zip"
echo "Consul Release: 1.3.0"
echo "Consul Download: 1.3.0"
curl -s -o /tmp/consul_1.3.0_linux_amd64.zip ${download}
unzip -o /tmp/consul_1.3.0_linux_amd64.zip -d /usr/local/bin/
chmod 755 /usr/local/bin/consul
chown consul:consul /usr/local/bin/consul
mkdir -p -v -m 755 /etc/consul.d
touch /etc/consul.d/consul.json
mkdir -p -v -m 755 /opt/consul/data
chown -R consul:consul /etc/consul.d /opt/consul
chmod -R 0777 /etc/consul.d/*
