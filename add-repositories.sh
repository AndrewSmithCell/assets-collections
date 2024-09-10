apt-get update
apt-get install -y ca-certificates curl gnupg
curl -fsSL https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg
cat > /etc/apt/sources.list.d/adoptium.sources <<EOF
Types: deb
URIs: https://packages.adoptium.net/artifactory/deb
Suites: bookworm
Components: main
Signed-By: /etc/apt/keyrings/adoptium.gpg
EOF
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
cat > /etc/apt/sources.list.d/nodesource.sources <<EOF
Types: deb
URIs: https://deb.nodesource.com/node_20.x
Suites: nodistro
Components: main
Signed-By:/etc/apt/keyrings/nodesource.gpg
EOF
sudo apt-get update        
