# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

### Deployment Commands
```bash
# Full deployment with all enabled features
ansible-playbook -i inventory/hosts.yml site.yml

# Deploy specific components
ansible-playbook -i inventory/hosts.yml playbooks/01_base_setup.yml
ansible-playbook -i inventory/hosts.yml playbooks/02_kiosk_touchscreen.yml
ansible-playbook -i inventory/hosts.yml playbooks/03_dakboard.yml
ansible-playbook -i inventory/hosts.yml playbooks/04_prepare_containers.yml
ansible-playbook -i inventory/hosts.yml playbooks/05_containers_homeassistant.yml
ansible-playbook -i inventory/hosts.yml playbooks/06_traefik_ingress.yml
ansible-playbook -i inventory/hosts.yml playbooks/07_k3s_control_plane.yml
ansible-playbook -i inventory/hosts.yml playbooks/08_k3s_worker_nodes.yml
ansible-playbook -i inventory/hosts.yml playbooks/09_homebridge.yml
ansible-playbook -i inventory/hosts.yml playbooks/10_mqtt_broker.yml
ansible-playbook -i inventory/hosts.yml playbooks/11_nodered.yml

# Using tags for selective deployment
ansible-playbook -i inventory/hosts.yml site.yml --tags base
ansible-playbook -i inventory/hosts.yml site.yml --skip-tags dakboard

# Dry run to check what would be changed
ansible-playbook -i inventory/hosts.yml site.yml --check

# Syntax check
ansible-playbook --syntax-check site.yml
```

### Testing and Validation
```bash
# Test connectivity to all hosts
ansible -i inventory/hosts.yml all -m ping

# Check if specific hosts are reachable
ansible -i inventory/hosts.yml pi_cluster -m ping

# Run ad-hoc commands on hosts
ansible -i inventory/hosts.yml pi_cluster -m command -a "uptime"
```

## Architecture Overview

This is a modular Ansible repository for managing Raspberry Pi infrastructure with a focus on kiosk displays, container orchestration, and home automation.

### Core Design Principles
- **Feature Flag Architecture**: Uses `group_vars/all.yml` feature flags to control which components are deployed
- **Modular Playbooks**: Each major component has its own playbook that can be run independently
- **Conditional Execution**: Playbooks are imported conditionally based on feature flags using `when` conditions
- **Role-Based Organization**: Functionality is organized into reusable roles under `roles/`

### Key Components

#### Infrastructure Layers
1. **Base Layer** (`base` role): System updates, security hardening, essential packages
2. **Display Layer** (`touchscreen`, `dakboard` roles): Kiosk functionality with display management
3. **Container Layer** (`container_prep` role): Docker and Kubernetes prerequisites
4. **IoT/Automation Layer** (`mqtt_broker`, `nodered` roles): MQTT messaging and Node-RED automation
5. **Application Layer** (K8s deployments): Home Assistant, Homebridge, Traefik

#### Host Groups
- `pi_cluster`: All Raspberry Pi nodes
- `control`: Kubernetes control plane nodes (typically pi-master)
- `workers`: Kubernetes worker nodes (expandable)

### Feature Flags
Control deployment scope via `group_vars/all.yml`:
- `enable_kiosk`: Touchscreen display controls and timers
- `enable_dakboard`: DAKboard kiosk mode setup
- `enable_containers`: Docker and container preparation
- `enable_homeassistant`: Home Assistant K8s deployment
- `enable_k3s`: Kubernetes cluster setup
- `enable_traefik`: Traefik ingress controller for K8s
- `enable_homebridge`: Homebridge K8s deployment
- `enable_mqtt`: MQTT broker (Mosquitto) for IoT messaging
- `enable_nodered`: Node-RED automation platform with Homebridge integration

### Key Files
- `site.yml`: Main orchestration playbook that imports all component playbooks
- `inventory/hosts.yml`: Host definitions and IP addresses
- `group_vars/all.yml`: Global configuration and feature flags
- `group_vars/control.yml`: Control plane specific configuration

### Deployment Patterns
- Playbooks are imported conditionally based on feature flags
- Each role is idempotent and can be run multiple times safely
- Uses handlers for service restarts and system reloads
- Templates (`.j2` files) are used for dynamic configuration generation

### Special Considerations
- Designed for Raspberry Pi OS Lite
- Assumes SSH key-based authentication
- DAKboard role creates dedicated `dakboard` user for kiosk mode
- K8s deployments are file-based (YAML manifests in `roles/*/files/`)
- Touchscreen role includes comprehensive display power management with systemd timers
- MQTT broker runs on port 1883 with optional authentication
- Node-RED runs on port 1880 with Homebridge integration on port 51826
- Node-RED includes example flows for MQTT to HomeKit bridge functionality