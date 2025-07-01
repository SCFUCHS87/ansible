# Ansible Playbook and Role Mapping

This document provides a comprehensive mapping of each playbook to its roles and describes the purpose of each role in the modular Raspberry Pi infrastructure.

## Playbook Overview

| # | Playbook | Feature Flag | Target Hosts | Description |
|---|----------|--------------|--------------|-------------|
| 01 | `01_base_setup.yml` | Always runs | `pi_cluster` | Foundation system setup |
| 02 | `02_kiosk_touchscreen.yml` | `enable_kiosk` | `all` | Touchscreen display management |
| 03 | `03_dakboard.yml` | `enable_dakboard` | `all` | DAKboard kiosk environment |
| 04 | `04_prepare_containers.yml` | `enable_containers` | `all` | Container platform preparation |
| 05 | `05_containers_homeassistant.yml` | `enable_homeassistant` | `all` | Home Assistant K8s deployment |
| 06 | `06_traefik_ingress.yml` | `enable_traefik` | `control` | Traefik ingress controller |
| 07 | `07_k3s_control_plane.yml` | `enable_k3s` | `control` | K3s master node setup |
| 08 | `08_k3s_worker_nodes.yml` | `enable_k3s` | `workers` | K3s worker node joining |
| 09 | `09_homebridge.yml` | `enable_homebridge` | `control` | Homebridge K8s deployment |
| 10 | `10_mqtt.yml` | `enable_mqtt` | `control` | MQTT broker K8s deployment |
| 11 | `11_nodered.yml` | `enable_nodered` | `control` | Node-RED K8s deployment |
| 12 | `12_postgresql.yml` | `enable_postgresql` | `control` | PostgreSQL K8s deployment |
| 13 | `12_pxe_server.yml` | `enable_pxe_server` | `control` | PXE boot server setup |

## Playbook-to-Role Mapping

### 01. Base Setup (`01_base_setup.yml`)
- **Role**: `base`
- **Purpose**: Foundation system configuration and security hardening
- **Key Functions**:
  - Updates and upgrades system packages
  - Installs essential utilities (curl, wget, git, vim, htop)
  - Configures automatic security updates
  - Hardens SSH configuration (disables root login and password auth)
  - Sets system timezone (default: America/Chicago)

### 02. Kiosk Touchscreen (`02_kiosk_touchscreen.yml`)
- **Role**: `touchscreen`
- **Purpose**: Comprehensive touchscreen display power management
- **Key Functions**:
  - Installs X11 utilities for display control
  - Creates systemd services and timers for scheduled display on/off
  - Implements touch-activated wake functionality
  - Configures auto-off timer after touch inactivity
  - Installs udev rules for touchscreen wake events
  - Provides AM/PM scheduled display management

### 03. DAKboard (`03_dakboard.yml`)
- **Role**: `dakboard`
- **Purpose**: Kiosk display setup for DAKboard dashboard
- **Key Functions**:
  - Installs X11 and Chromium browser packages
  - Creates dedicated `dakboard` user for kiosk mode
  - Configures auto-login for dakboard user on tty1
  - Sets up Chromium in kiosk mode with DAKboard optimizations
  - Disables screen blanking and power management
  - Launches full-screen browser pointing to configurable DAKboard URL

### 04. Container Preparation (`04_prepare_containers.yml`)
- **Role**: `container_prep`
- **Purpose**: Prepares system for container orchestration
- **Key Functions**:
  - Installs Docker CE, CLI, containerd, and docker-compose-plugin
  - Adds Docker GPG key and repository
  - Adds ansible user to docker group
  - Installs Python Kubernetes libraries (kubernetes, PyYAML)
  - Sets up prerequisites for K8s deployments

### 05. Home Assistant (`05_containers_homeassistant.yml`)
- **Role**: `k8s_homeassistant`
- **Purpose**: Deploys Home Assistant to Kubernetes cluster
- **Key Functions**:
  - Deploys Home Assistant container (ghcr.io/home-assistant/home-assistant:stable)
  - Supports optional PostgreSQL database integration
  - Mounts persistent storage for configuration
  - Creates service for internal cluster access
  - Configures trusted proxies for reverse proxy scenarios

### 06. Traefik Ingress (`06_traefik_ingress.yml`)
- **Role**: `k8s_traefik_ingress_controller`
- **Purpose**: Provides ingress controller for Kubernetes services
- **Key Functions**:
  - Deploys Traefik ingress controller to Kubernetes
  - Provides reverse proxy and load balancing for K8s services
  - Manages external access to cluster services
  - Handles routing and SSL termination

### 07. K3s Control Plane (`07_k3s_control_plane.yml`)
- **Role**: `kubernetes_control_plane`
- **Purpose**: Installs and configures K3s master node
- **Key Functions**:
  - Installs K3s server with proper kubeconfig permissions
  - Waits for K3s API server to be ready
  - Extracts and shares K3s node token for worker nodes
  - Sets up the control plane for the Kubernetes cluster

### 08. K3s Worker Nodes (`08_k3s_worker_nodes.yml`)
- **Role**: `kubernetes_worker_node`
- **Purpose**: Joins worker nodes to the K3s cluster
- **Key Functions**:
  - Retrieves K3s token from control plane
  - Installs K3s agent on worker nodes
  - Joins worker nodes to the existing cluster
  - Establishes communication with control plane

### 09. Homebridge (`09_homebridge.yml`)
- **Role**: `k8s_homebridge`
- **Purpose**: Deploys Homebridge for Apple HomeKit integration
- **Key Functions**:
  - Deploys Homebridge container (oznu/homebridge:latest) to K8s
  - Creates persistent volume for Homebridge configuration
  - Exposes service on port 8581
  - Provides Apple HomeKit bridge functionality

### 10. MQTT Broker (`10_mqtt.yml`)
- **Role**: `mqtt`
- **Purpose**: Deploys MQTT broker to Kubernetes for IoT messaging
- **Key Functions**:
  - Creates dedicated MQTT namespace in Kubernetes
  - Deploys Eclipse Mosquitto MQTT broker
  - Supports optional authentication with username/password
  - Creates persistent volume for MQTT data
  - Exposes both internal (ClusterIP) and external (NodePort) services
  - Configures MQTT on port 1883 and WebSocket on port 9001

### 11. Node-RED (`11_nodered.yml`)
- **Role**: `nodered`
- **Purpose**: Deploys Node-RED automation platform with IoT integrations
- **Key Functions**:
  - Deploys Node-RED to Kubernetes with persistent storage
  - Pre-configures MQTT broker and Home Assistant connections
  - Installs additional packages (Home Assistant WebSocket, Dashboard UI, HomeKit bridge, Email)
  - Includes example flows for MQTT to HomeKit bridging
  - Exposes on port 1880 with optional external access
  - Integrates with Homebridge for HomeKit automation

### 12. PostgreSQL (`12_postgresql.yml`)
- **Role**: `postgresql`
- **Purpose**: Deploys PostgreSQL database to Kubernetes
- **Key Functions**:
  - Deploys PostgreSQL to Kubernetes cluster
  - Creates secret for database credentials
  - Sets up persistent volume claim for data storage
  - Configures database deployment and service
  - Provides persistent database for applications like Home Assistant

### 13. PXE Server (`12_pxe_server.yml`)
- **Role**: `pxe_server`
- **Purpose**: Sets up network boot server for automated Pi deployment
- **Key Functions**:
  - Installs and configures dnsmasq, TFTP, and NFS services
  - Downloads and prepares Raspberry Pi OS images
  - Sets up network boot environment for Pi devices
  - Configures DHCP, TFTP, and NFS for netboot
  - Enables automated Pi deployment over network
  - Opens necessary firewall ports for PXE services

## Role Categories

### Infrastructure Foundation
- **`base`**: System foundation and security
- **`container_prep`**: Container platform preparation
- **`kubernetes_control_plane`**: K8s master setup
- **`kubernetes_worker_node`**: K8s worker setup

### Display and Kiosk
- **`touchscreen`**: Display power management
- **`dakboard`**: Kiosk dashboard setup

### Kubernetes Applications
- **`k8s_homeassistant`**: Home automation platform
- **`k8s_homebridge`**: Apple HomeKit bridge
- **`k8s_traefik_ingress_controller`**: Reverse proxy and ingress
- **`mqtt`**: MQTT messaging broker
- **`nodered`**: Visual automation platform
- **`postgresql`**: Database service

### Network Services
- **`pxe_server`**: Network boot server

## Unused Roles

### `mqtt_broker`
- **Status**: Present in filesystem but not used by any playbook
- **Purpose**: Direct system installation of MQTT broker (alternative to K8s deployment)
- **Note**: This role provides a non-containerized MQTT broker installation, but the active deployment uses the `mqtt` role for Kubernetes-based deployment

## Architecture Patterns

### Deployment Strategies
1. **Direct Installation**: Roles that install services directly on the host system (`base`, `touchscreen`, `dakboard`, `mqtt_broker`, `pxe_server`)
2. **Kubernetes Deployment**: Roles that deploy applications as containers in K8s (`mqtt`, `nodered`, `k8s_*`)
3. **Infrastructure Setup**: Roles that prepare the system for other services (`container_prep`, `kubernetes_*`)

### Integration Points
- **MQTT** serves as the central IoT message hub
- **Node-RED** bridges MQTT to HomeKit via Homebridge integration
- **Home Assistant** can use PostgreSQL for data persistence
- **Traefik** provides ingress routing for all K8s services
- **Touchscreen** role supports kiosk displays managed by dakboard role

### Configuration Management
- Extensive use of Jinja2 templates for dynamic configuration
- Feature flags in `group_vars/all.yml` control optional components
- Persistent volumes ensure data survives container restarts
- Network policies and service discovery built into K8s deployments