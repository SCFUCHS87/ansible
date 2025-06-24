# Friend Setup Playbook: friend_setup.yml

This Ansible setup is tailored for x86 systems and provides optional installation of Home Assistant and Homebridge via Docker.

---

## 🧾 What This Does
- ✅ Detects and installs Docker if it's not already present.
- ✅ Prompts you whether to install:
  - [Home Assistant](https://www.home-assistant.io/)
  - [Homebridge](https://homebridge.io/)
- ✅ Deploys each in its own Docker container.

---

## 📁 Files Included

```
inventory.friend.yml
playbooks/
  └── friend_setup.yml
roles/
  ├── docker/
  │   └── tasks/main.yml
  ├── homeassistant/
  │   └── tasks/main.yml
  └── homebridge/
      └── tasks/main.yml
```

---

## 🚀 How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/SCFUCHS87/ansible.git
   cd ansible
   git checkout friend-setup
   ```

2. Edit `inventory.friend.yml` if needed:
   ```yaml
   all:
     hosts:
       ha-x86:
         ansible_host: 192.168.1.123
         ansible_user: youruser
   ```

3. Run the playbook:
   ```bash
   ansible-playbook -i inventory.friend.yml playbooks/friend_setup.yml
   ```

4. Answer the prompts:
   ```
   Install Home Assistant? (yes/no)
   Install Homebridge? (yes/no)
   ```

---

## 📦 Output

If selected, the following containers will run:
- `homeassistant`: accessible on host network (usually http://<ip>:8123)
- `homebridge`: accessible on http://<ip>:8581

---

## 🛠 Requirements
- A fresh x86 Linux machine
- Ansible installed on your control machine (`sudo apt install ansible`)
- SSH access from Ansible host to the target machine

---

## 🧹 Optional Improvements
- Add Cloudflare Tunnel, Watchtower, or Nginx roles
- Create a reverse proxy for public access (via Docker or Nginx)
- Add SSL/TLS support for Home Assistant and Homebridge

---

## 🧠 Tip
You can re-run the playbook at any time to add/remove services safely!
