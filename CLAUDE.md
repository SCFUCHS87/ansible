# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## ✅ Validation Status

**Last Validated**: July 1, 2025  
**Status**: Production Ready ✅  
**Configuration**: Fully validated and tested

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
ansible-playbook -i inventory/hosts.yml playbooks/10_mqtt.yml
ansible-playbook -i inventory/hosts.yml playbooks/11_nodered.yml
ansible-playbook -i inventory/hosts.yml playbooks/13_ai_stack.yml

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

# Validate configuration before deployment
ansible-playbook -i inventory/hosts.yml site.yml --check --diff

# Complete validation check (comprehensive)
ansible-playbook --syntax-check -i inventory/hosts.yml site.yml
```

### Vault Management
```bash
# Create encrypted vault file
ansible-vault create group_vars/vault.yml

# Edit encrypted vault file  
ansible-vault edit group_vars/vault.yml

# Encrypt existing vault file
ansible-vault encrypt group_vars/vault.yml

# View encrypted vault file
ansible-vault view group_vars/vault.yml
```

## Architecture Overview

This is a modular Ansible repository for managing Raspberry Pi infrastructure with a focus on kiosk displays, container orchestration, home automation, and AI assistant interfaces.

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
4. **IoT/Automation Layer** (`mqtt`, `nodered` roles): MQTT messaging and Node-RED automation
5. **Application Layer** (K8s deployments): Home Assistant, Homebridge, Traefik
6. **AI Interface Layer** (`k8s_open_webui`, `k8s_piper`, `k8s_whisper`, `k8s_ai_gateway`): LLM interface, TTS/STT, API gateway

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
- `enable_ai_stack`: Complete AI assistant stack (Open WebUI + TTS/STT + Gateway)
- `enable_open_webui`: Open WebUI interface for LLMs
- `enable_piper`: Piper text-to-speech service
- `enable_whisper`: Whisper speech-to-text service  
- `enable_ai_gateway`: AI API gateway/proxy for routing requests

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

### AI Stack Integration
- Open WebUI connects to external Ollama server (configurable IP)
- Piper TTS service uses Wyoming protocol on port 31200
- Whisper STT service uses Wyoming protocol on port 31300
- AI Gateway provides API proxy/routing on port 31000
- All AI services deployed as Kubernetes pods with persistent storage
- Supports both local LLM (via external Ollama) and cloud APIs (OpenAI/Anthropic)

## 🚀 Quick Start

### Prerequisites
1. Raspberry Pi with SSH access configured
2. External LLM server running Ollama (optional for AI stack)
3. Ansible installed on control machine

### Basic Deployment
```bash
# 1. Update configuration
vim group_vars/all.yml  # Set feature flags and external_ollama_host
ansible-vault edit group_vars/vault.yml  # Add real tokens/passwords

# 2. Validate configuration
ansible-playbook --syntax-check -i inventory/hosts.yml site.yml
ansible -i inventory/hosts.yml pi_cluster -m ping

# 3. Deploy (dry run first)
ansible-playbook -i inventory/hosts.yml site.yml --check --ask-vault-pass

# 4. Full deployment
ansible-playbook -i inventory/hosts.yml site.yml --ask-vault-pass
```

### Service Access Points
After deployment, services will be available at:
- **Open WebUI**: http://pi-ip:31080 (AI chat interface)
- **Node-RED**: http://pi-ip:31880 (automation flows)
- **MQTT**: tcp://pi-ip:31883 (IoT messaging)
- **Piper TTS**: tcp://pi-ip:31200 (text-to-speech)
- **Whisper STT**: tcp://pi-ip:31300 (speech-to-text)
- **AI Gateway**: http://pi-ip:31000 (API proxy)