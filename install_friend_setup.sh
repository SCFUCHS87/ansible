#!/bin/bash
set -e

echo "🔍 Fetching latest Friend Setup version..."
LATEST_TAG=$(curl -s https://api.github.com/repos/SCFUCHS87/ansible/releases/latest | jq -r .tag_name)

echo "📦 Downloading install script from tag: $LATEST_TAG"
curl -sL "https://raw.githubusercontent.com/SCFUCHS87/ansible/${LATEST_TAG}/install_friend_setup.sh" | bash

echo "📦 Downloading full release archive for $LATEST_TAG"
curl -sL "https://github.com/SCFUCHS87/ansible/archive/refs/tags/${LATEST_TAG}.tar.gz" -o friend-setup.tar.gz

echo "📂 Extracting..."
tar -xzf friend-setup.tar.gz

echo "🚀 Running playbook..."
cd "ansible-${LATEST_TAG}"
ansible-playbook -i inventory.friend.yml site.yml
