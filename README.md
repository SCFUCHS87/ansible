## Friend Setup (x86 with Docker)

Looking to install Home Assistant or Homebridge on an x86 system?

👉 See [readme.friendsetup.md](readme.friendsetup.md)


This Ansible setup is tailored for x86 systems and provides optional installation of Home Assistant and Homebridge via Docker, with improved security and reliability.

If you already have Docker containers running, make sure the ports 8123 and 8581 are not in use. You’ll be prompted to override them during setup.

---

## 🧾 What This Does
- ✅ Secures the system with SSH hardening and automatic security updates
- ✅ Detects and properly installs Docker with all dependencies
- ✅ Prompts you whether to install Home Assistant and/or Homebridge
- ✅ Configures firewall rules for enabled services
- ✅ Deploys each service in its own Docker container with health checks
- ✅ Provides cleanup capabilities

---

## 📁 Files Structure

```
├── inventory.friend.yml          # Host inventory
├── site.yml                      # Main entry point
├── group_vars/
│   └── all.yml                   # Common variables
├── playbooks/
│   ├── friend_setup.yml          # Main setup playbook
│   └── cleanup.yml               # Service removal playbook
└── roles/
    ├── base/                     # System hardening & essentials
    ├── docker/                   # Docker installation
    ├── firewall/                 # UFW firewall setup
    ├── homeassistant/           # Home Assistant deployment
    └── homebridge/              # Homebridge deployment
```

---

## 🚀 How to Use

1. **Clone and checkout:**
   ```bash
   git clone https://github.com/SCFUCHS87/ansible.git
   cd ansible
   git checkout friend-setup
   ```

2. **Update inventory:**
   ```bash
   # Edit inventory.friend.yml with your target system details
   vim inventory.friend.yml
   ```

3. **Run the setup:**
   ```bash
   ansible-playbook -i inventory.friend.yml site.yml
   ```

4. **Answer the prompts:**
   - Install Home Assistant? (yes/no)
   - Install Homebridge? (yes/no)

---

## 🎯 Usage Examples

**Full installation:**
```bash
ansible-playbook -i inventory.friend.yml site.yml
```

**Only base system setup:**
```bash
ansible-playbook -i inventory.friend.yml site.yml --tags base
```

**Only Home Assistant:**
```bash
ansible-playbook -i inventory.friend.yml site.yml --tags homeassistant
```

**Cleanup services:**
```bash
ansible-playbook -i inventory.friend.yml playbooks/cleanup.yml
```

---

## 📦 What You Get

After successful deployment:
- **Home Assistant**: http://your-server-ip:8123 (if selected)
- **Homebridge**: http://your-server-ip:8581 (if selected)
- **Secured SSH**: Password authentication disabled, root login disabled
- **Automatic updates**: Security updates install automatically
- **Firewall**: UFW configured with only necessary ports open

---

## 🛠 Requirements

- **Target system**: Fresh x86_64 Linux machine (Ubuntu/Debian)
- **Control machine**: Ansible installed (`sudo apt install ansible`)
- **Network**: SSH access from control machine to target
- **Permissions**: sudo access on target machine

---

## ⚙️ Configuration

Edit `group_vars/all.yml` to customize:
- Timezone settings
- Docker versions
- Security policies
- Service versions

---

## 🔧 Troubleshooting

**Docker installation fails:**
```bash
# Check system architecture
ansible all -i inventory.friend.yml -m setup -a "filter=ansible_architecture"
```

**Services not accessible:**
```bash
# Check firewall status
ansible all -i inventory.friend.yml -m shell -a "ufw status" --become
```

**Container issues:**
```bash
# Check container status
ansible all -i inventory.friend.yml -m shell -a "docker ps -a" --become
```

---

## 🧠 Pro Tips

- **Re-run safely**: The playbook is idempotent - run it multiple times safely
- **Selective deployment**: Use tags to install only specific components
- **Easy cleanup**: Use the cleanup playbook to remove services cleanly
- **Backup configs**: Home Assistant and Homebridge configs are in `/opt/`

---

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 💬 Feedback & Support

### 🐛 Found an Issue?
[Report a bug or issue](https://github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=support-request.md)

### 💡 Have Feedback?
[Share your experience](https://github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=friend-feedback.md)

### 💬 General Questions?
[Start a discussion](https://github.com/SCFUCHS87/ansible/discussions) or email directly!

### 📧 Direct Contact
Prefer email? Reach out directly for any questions or suggestions.
