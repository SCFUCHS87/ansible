# Friend Setup: Home Assistant + Homebridge (x86 via Ansible + Docker)

This is a minimal Ansible playbook for deploying Docker, Home Assistant, and Homebridge on a clean x86 Linux system. It checks for Docker, installs it if missing, and then prompts you to install either or both of the home automation services.

---

## 📚 Table of Contents
- [What This Does](#what-this-does)
- [Files Included](#files-included)
- [How to Use](#how-to-use)
- [Output](#output)
- [Requirements](#requirements)
- [Optional Improvements](#optional-improvements)

---

## ✅ What This Does

- Installs Docker (if not already installed)
- Prompts for optional installation of:
  - [Home Assistant](https://www.home-assistant.io/)
  - [Homebridge](https://homebridge.io/)
- Deploys each service as a self-contained Docker container with persistent volumes

---

## 📁 Files Included

~/ansible friend-setup* 13s
❯ cat readme.friendsetup.md
# Friend Setup: Home Assistant + Homebridge (x86 via Ansible + Docker)

This is a minimal Ansible playbook for deploying Docker, Home Assistant, and Homebridge on a clean x86 Linux system. It checks for Docker, installs it if missing, and then prompts you to install either or both of the home automation services.

---

## 📚 Table of Contents
- [What This Does](#what-this-does)
- [Files Included](#files-included)
- [How to Use](#how-to-use)
- [Output](#output)
- [Requirements](#requirements)
- [Optional Improvements](#optional-improvements)

---

## ✅ What This Does

- Installs Docker (if not already installed)
- Prompts for optional installation of:
  - [Home Assistant](https://www.home-assistant.io/)
  - [Homebridge](https://homebridge.io/)
- Deploys each service as a self-contained Docker container with persistent volumes

---

## 📁 Files Included

inventory.friend.yml # Inventory with target x86 host
playbooks/friend_setup.yml # Playbook that prompts and installs optional roles
roles/
├── base/ # Optional system prep or user config
├── docker/ # Docker installation if not present
├── homeassistant/ # Docker container for Home Assistant
└── homebridge/ # Docker container for Homebridge
site.yml # Entrypoint to run everything


---

## 🚀 How to Use

1. Clone the repo and switch to the `friend-setup` branch:
   ```bash
   git clone --branch friend-setup https://github.com/SCFUCHS87/ansible.git
   cd ansible

2. Edit inventory.friend.yml with yoru x86 machine's IP and user:
all:
  hosts:
    ha-x86:
      ansible_host: 192.168.1.123
      ansible_user: youruser

3.  Run the playbook:
ansible-playbook -i inventory.friend.yml site.yml
4.  Respond to the prompts
Install Home Assistant? (yes/no):
Install Homebridge? (yes/no):

🧾 Output
If selected, the following containers will run:

Home Assistant
Accessible at: http://<your_ip>:8123
Data stored at: /opt/homeassistant

Homebridge
Accessible at: http://<your_ip>:8581
Data stored at: /opt/homebridge

To restart, stop, or view logs, use standard Docker commands.


🛠 Requirements
Fresh x86 Linux machine (e.g., Ubuntu, Debian)

SSH access from your Ansible control machine

Python + Ansible installed on the control machine:

bash
Copy code
sudo apt update && sudo apt install ansible


🧩 Optional Improvements
You can expand this setup by adding:

Watchtower — auto-update Docker containers

Cloudflare Tunnel — secure public access

Nginx Proxy Manager — frontend for reverse proxy + SSL

Integration with MQTT, Node-RED, or Zigbee2MQTT


💬 Need Help?
Contact the person who gave you this repo or open an issue on GitHub.
