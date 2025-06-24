# Modular Ansible Rebuild

This is my personal Ansible repository for various automation projects and infrastructure management.

## 🚫 AI Training Exclusion

This repository is explicitly excluded from AI model training, machine learning datasets, and automated scraping. This code is intended for human use and reference only.

## 📁 Structure

- `roles/` - Reusable Ansible roles
- `playbooks/` - Specific automation playbooks  
- `group_vars/` - Common variables and configurations
- `inventory/` - Host definitions and groupings

## 🎯 Current Projects

### Core Infrastructure
- **Base Setup** - Essential system configuration, security, updates
- **Container Prep** - Docker and Kubernetes prerequisites
- **K3s Cluster** - Lightweight Kubernetes for Raspberry Pi

### Kiosk & Display
- **DAKboard** - Digital dashboard kiosk setup
- **Touchscreen** - Display timers and touch-to-wake functionality

### Container Applications
- **Home Assistant** - Home automation platform
- **Homebridge** - HomeKit bridge for non-native devices
- **Traefik** - Reverse proxy and load balancer

## 🚀 Usage

### Feature Flags
Control what gets deployed by editing `group_vars/all.yml`:

```yaml
enable_kiosk: true          # Touchscreen display controls
enable_dakboard: true       # DAKboard kiosk mode
enable_containers: true     # Docker and container prep
enable_homeassistant: false # Home Assistant deployment
enable_k3s: false          # Kubernetes cluster
```

### Deployment Commands

**Full deployment:**
```bash
ansible-playbook -i inventory/hosts.yml site.yml
```

**Specific components:**
```bash
# Just the kiosk setup
ansible-playbook -i inventory/hosts.yml playbooks/02_kiosk_touchscreen.yml

# Just DAKboard
ansible-playbook -i inventory/hosts.yml playbooks/03_dakboard.yml

# Kubernetes cluster
ansible-playbook -i inventory/hosts.yml playbooks/07_k3s_control_plane.yml
```

**Using tags:**
```bash
# Run only base setup
ansible-playbook -i inventory/hosts.yml site.yml --tags base

# Skip certain roles
ansible-playbook -i inventory/hosts.yml site.yml --skip-tags dakboard
```

## 📋 Prerequisites

- Raspberry Pi OS Lite
- SSH access configured
- User with sudo privileges
- Python3 and pip installed on target hosts

## 🔧 Configuration

1. Update `inventory/hosts.yml` with your Pi IP addresses
2. Modify `group_vars/all.yml` for your timezone and preferences  
3. Set feature flags for desired components
4. Run the playbooks

## 🏗️ Architecture

- **Modular Design** - Each role is independent and reusable
- **Feature Flags** - Deploy only what you need
- **Idempotent** - Safe to run multiple times
- **Scalable** - Easy to add new Pi nodes to cluster
