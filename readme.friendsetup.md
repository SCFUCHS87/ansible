---

## 🧩 One-Liner Installer (Optional)

Want to try this without cloning manually?

```bash
curl -sL https://raw.githubusercontent.com/SCFUCHS87/ansible/friend-setup/install_friend_setup.sh | bash


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

---

### 🐧 Distro Compatibility (Ubuntu, Debian, Fedora, Arch)

This setup is now compatible with:

| Distro         | Status  | Notes                                         |
|----------------|---------|-----------------------------------------------|
| Ubuntu 22.04+  | ✅ Works | Fully tested with the Docker install script   |
| Debian 12+     | ✅ Works | Fully tested with the Docker install script   |
| Fedora 38+     | ✅ Works | Uses native `dnf` to install Docker           |
| Arch Linux     | ✅ Works | Uses native `pacman` to install Docker        |

Docker will be installed automatically using the appropriate method for your distro:
- Ubuntu/Debian: via Docker's official install script
- Fedora: via `dnf install docker docker-compose`
- Arch: via `pacman -S docker`

The playbook will also enable and start the Docker service.

---

### ⚠️ Notes for Arch and Fedora Users

- Ensure your user is in the `docker` group after install:
```bash
sudo usermod -aG docker $USER
Then log out and back in, or newgrp docker.

If Ansible cannot manage Docker post-install, you may need to reboot or manually start Docker with:

bash
Copy code
sudo systemctl enable --now docker


---

### 🐧 Distro Compatibility (Ubuntu, Debian, Fedora, Arch)

This setup is now compatible with:

| Distro         | Status  | Notes                                         |
|----------------|---------|-----------------------------------------------|
| Ubuntu 22.04+  | ✅ Works | Fully tested with the Docker install script   |
| Debian 12+     | ✅ Works | Fully tested with the Docker install script   |
| Fedora 38+     | ✅ Works | Uses native `dnf` to install Docker           |
| Arch Linux     | ✅ Works | Uses native `pacman` to install Docker        |

Docker will be installed automatically using the appropriate method for your distro:
- Ubuntu/Debian: via Docker's official install script
- Fedora: via `dnf install docker docker-compose`
- Arch: via `pacman -S docker`

The playbook will also enable and start the Docker service.

---

### ⚠️ Notes for Arch and Fedora Users

- Ensure your user is in the `docker` group after install:
```bash
sudo usermod -aG docker $USER
Then log out and back in, or newgrp docker.

If Ansible cannot manage Docker post-install, you may need to reboot or manually start Docker with:

bash
Copy code
sudo systemctl enable --now docker

---\n\n### 🐧 Distro Compatibility (Ubuntu, Debian, Fedora, Arch)\n\nThis setup is now compatible with:\n\n| Distro         | Status  | Notes                                         |\n|----------------|---------|-----------------------------------------------|\n| Ubuntu 22.04+  | ✅ Works | Fully tested with the Docker install script   |\n| Debian 12+     | ✅ Works | Fully tested with the Docker install script   |\n| Fedora 38+     | ✅ Works | Uses native `dnf` to install Docker           |\n| Arch Linux     | ✅ Works | Uses native `pacman` to install Docker        |\n\nDocker will be installed automatically using the appropriate method for your distro:\n- Ubuntu/Debian: via Docker's official install script\n- Fedora: via `dnf install docker docker-compose`\n- Arch: via `pacman -S docker`\n\nThe playbook will also enable and start the Docker service.\n\n---\n\n### ⚠️ Notes for Arch and Fedora Users\n\n- Ensure your user is in the `docker` group after install:\n  ```bash\n  sudo usermod -aG docker $USER\n  ```\n  Then log out and back in, or `newgrp docker`.\n\n- If Ansible cannot manage Docker post-install, you may need to reboot or manually start Docker with:\n  ```bash\n  sudo systemctl enable --now docker\n  ```
