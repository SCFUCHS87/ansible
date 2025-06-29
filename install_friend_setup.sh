#!/bin/bash

set -e

LATEST_TAG=$(curl -s https://api.github.com/repos/SCFUCHS87/ansible/releases/latest | jq -r .tag_name)
INSTALL_URL="https://raw.githubusercontent.com/SCFUCHS87/ansible/${LATEST_TAG}/install_friend_setup.sh"

echo "📦 Downloading Friend Setup v${LATEST_TAG}..."
curl -sL "${INSTALL_URL}" | bash


echo "📂 Extracting..."
tar -xzf friend-setup.tar.gz
cd ansible-friend-setup-v1.0.0

echo "🚀 Running playbook..."
ansible-playbook -i inventory.friend.yml site.yml
