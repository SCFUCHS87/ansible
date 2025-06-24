#!/bin/bash

set -e

RELEASE_URL="https://github.com/SCFUCHS87/ansible/archive/refs/tags/friend-setup-v1.0.0.tar.gz"

echo "📦 Downloading friend-setup..."
curl -L "$RELEASE_URL" -o friend-setup.tar.gz

echo "📂 Extracting..."
tar -xzf friend-setup.tar.gz
cd ansible-friend-setup-v1.0.0

echo "🚀 Running playbook..."
ansible-playbook -i inventory.friend.yml site.yml
