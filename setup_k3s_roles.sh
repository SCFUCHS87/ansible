#!/bin/bash
set -e

echo "📦 Creating Kubernetes roles for k3s cluster..."

mkdir -p roles/kubernetes_control_plane/tasks
mkdir -p roles/kubernetes_worker_node/tasks
mkdir -p playbooks
mkdir -p group_vars

# Control Plane Role
cat <<EOF > roles/kubernetes_control_plane/tasks/main.yml
---
- name: Install k3s server
  shell: |
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644" sh -
  args:
    creates: /etc/systemd/system/k3s.service

- name: Get k3s token
  slurp:
    src: /var/lib/rancher/k3s/server/node-token
  register: k3s_token_raw

- name: Set k3s token fact
  set_fact:
    k3s_token: "{{ k3s_token_raw['content'] | b64decode | trim }}"
EOF

# Worker Node Role
cat <<EOF > roles/kubernetes_worker_node/tasks/main.yml
---
- name: Install k3s agent
  shell: |
    curl -sfL https://get.k3s.io | K3S_URL="https://{{ k3s_control_ip }}:6443" K3S_TOKEN="{{ k3s_token }}" sh -
  args:
    creates: /etc/systemd/system/k3s-agent.service
EOF

# Playbooks
cat <<EOF > playbooks/07_k3s_control_plane.yml
---
- name: Install k3s control plane
  hosts: control
  become: true
  roles:
    - kubernetes_control_plane
EOF

cat <<EOF > playbooks/08_k3s_worker_nodes.yml
---
- name: Join worker nodes to k3s cluster
  hosts: workers
  become: true
  roles:
    - kubernetes_worker_node
EOF

# Update site.yml if it exists
if [ -f site.yml ]; then
  echo "" >> site.yml
  echo "- import_playbook: playbooks/07_k3s_control_plane.yml" >> site.yml
  echo "  when: enable_k3s | default(false)" >> site.yml
  echo "- import_playbook: playbooks/08_k3s_worker_nodes.yml" >> site.yml
  echo "  when: enable_k3s | default(false)" >> site.yml
fi

# Group Vars
cat <<EOF > group_vars/control.yml
k3s_control_ip: 192.168.1.100  # Update to your actual control plane IP
EOF

echo "✅ Kubernetes k3s roles and playbooks created."
