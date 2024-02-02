#!/bin/bash

if ! grep -qs '/var/lib/clickhouse ' /proc/mounts; then
  sudo mkdir -p /var/lib/clickhouse
  sudo mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/disk/by-id/google-${device_name}
  echo '/dev/disk/by-id/google-${device_name} /var/lib/clickhouse ext4 rw,noatime,nofail 0 2' | sudo tee -a /etc/fstab
  sudo mount -a
  sudo chmod 777 /var/lib/clickhouse
fi

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Navigate to /var/lib/clickhouse
cd /var/lib/clickhouse

# Check if compose.yaml exists and run Docker Compose
if [ -f "compose.yaml" ]; then
    sudo docker compose -f compose.yaml up -d
fi
