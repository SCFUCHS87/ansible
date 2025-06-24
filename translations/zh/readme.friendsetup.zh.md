
> 🌍 本README也提供以下语言版本:[🇨🇳 中文](translations/zh/readme.friendsetup.zh.md)

---

## 🧩 一键安装器(可选)

想要尝试而不手动克隆?

```bash
curl -sL https://raw.githubusercontent.com/SCFUCHS87/ansible/friend-setup/install_friend_setup.sh | bash
```

# Friend Setup:Home Assistant + Homebridge(x86 通过 Ansible + Docker)

这是一个最小的Ansible playbook，用于在干净的x86 Linux系统上部署Docker、Home Assistant和Homebridge。它检查Docker，如果缺失则安装，然后询问您是否要安装Home Assistant、Homebridge或两者。

---

## 📚 目录
- [功能说明](#功能说明)
- [包含的文件](#包含的文件)
- [如何使用](#如何使用)
- [输出](#输出)
- [要求](#要求)
- [可选改进](#可选改进)

---

## ✅ 功能说明

- 安装Docker(如果尚未安装)
- 询问可选安装:
  - [Home Assistant](https://www.home-assistant.io/)
  - [Homebridge](https://homebridge.io/)
- 将每个服务部署为独立的Docker容器，具有持久卷

---

## 📁 包含的文件

```
inventory.friend.yml          # 带有目标x86主机的清单
playbooks/friend_setup.yml    # 询问并安装可选角色的playbook
roles/
├── base/                     # 可选的系统准备或用户配置
├── docker/                   # Docker安装(如果不存在)
├── homeassistant/           # Home Assistant的Docker容器
└── homebridge/              # Homebridge的Docker容器
site.yml                     # 所有功能的入口点
```

---

## 🚀 如何使用

1. **克隆仓库并切换到`friend-setup`分支:**
   ```bash
   git clone --branch friend-setup https://github.com/SCFUCHS87/ansible.git
   cd ansible
   ```

2. **编辑inventory.friend.yml，填入您的x86机器IP和用户:**
   ```yaml
   all:
     hosts:
       ha-x86:
         ansible_host: 192.168.1.123
         ansible_user: 您的用户名
   ```

3. **运行playbook:**
   ```bash
   ansible-playbook -i inventory.friend.yml site.yml
   ```

4. **响应提示:**
   - 安装Home Assistant?(yes/no)
   - 安装Homebridge?(yes/no)

---

## 🧾 输出

如果选择，将运行以下容器:

**Home Assistant**
- 访问地址:http://您的IP:8123
- 数据存储在:/opt/homeassistant

**Homebridge**  
- 访问地址:http://您的IP:8581
- 数据存储在:/opt/homebridge

要重启、停止或查看日志，请请使用标准的Docker命令。

---

## 🛠 要求

- **新的x86 Linux机器**(例如Ubuntu、Debian)
- **从您的Ansible控制机器进行SSH访问**
- **在控制机器上安装Python + Ansible**:
  ```bash
  sudo apt update && sudo apt install ansible
  ```

---

## 🧩 可选改进

您可以通过添加以下内容来扩展此设置:

- **Watchtower** — Docker容器自动更新
- **Cloudflare Tunnel** — 安全的公共访问
- **Nginx Proxy Manager** — 反向代理 + SSL的前端
- **集成** MQTT、Node-RED或Zigbee2MQTT

---

## 💬 反馈和支持

### 🐛 发现问题?
[报告错误或问题](https://github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=support-request.md)

### 💡 有反馈?
[分享您的体验](https://github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=friend-feedback.md)

### 💬 一般问题?
[开始讨论](https://github.com/SCFUCHS87/ansible/discussions)或直接发邮件！

### 📧 直接联系
更喜欢邮件?请直接联系我们，提出任何问题或建议。

---

### 🐧 发行版兼容性(Ubuntu、Debian、Fedora、Arch)

此设置现在兼容:

| 发行版         | 状态    | 注释                                          |
|----------------|---------|-----------------------------------------------|
| Ubuntu 22.04+  | ✅ 工作正常 | 完全测试了Docker安装脚本                      |
| Debian 12+     | ✅ 工作正常 | 完全测试了Docker安装脚本                      |
| Fedora 38+     | ✅ 工作正常 | 使用原生`dnf`安装Docker                       |
| Arch Linux     | ✅ 工作正常 | 使用原生`pacman`安装Docker                    |

Docker将使用适合您发行版的方法自动安装:
- Ubuntu/Debian:通过Docker官方安装脚本
- Fedora:通过`dnf install docker docker-compose`
- Arch:通过`pacman -S docker`

playbook还将启用并启动Docker服务。

---

### ⚠️ Arch和Fedora用户注意事项

- 确保您的用户在安装后加入`docker`组:
  ```bash
  sudo usermod -aG docker $USER
  ```
  然后注销并重新登录，或使用`newgrp docker`。

- 如果Ansible在安装后无法管理Docker，您可能需要重启或手动启动Docker:
  ```bash
  sudo systemctl enable --now docker
  ```

---

💬 **需要帮助?**
联系给您这个仓库的人或在GitHub上开issue。

---

