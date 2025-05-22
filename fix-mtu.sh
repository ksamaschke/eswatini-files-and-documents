#!/bin/bash
set -euo pipefail

echo "=== Configuring Docker and KIND for MTU 1300 ==="

# Step 1: Configure Docker's MTU
echo "Configuring Docker daemon with MTU 1300..."
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json > /dev/null << 'EOF'
{
  "mtu": 1300,
  "log-level": "warn",
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "5"
  }
}
EOF

# Restart Docker to apply settings
echo "Restarting Docker service..."
sudo systemctl restart docker