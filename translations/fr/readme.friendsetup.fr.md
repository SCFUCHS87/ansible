> 🌍 Ce README est également disponible en ： [🇫🇷 Français](translations/readme.friendsetup.fr.md)

---

## 🧩 Installateur en Une Ligne (Optionnel)

Vous voulez l'essayer sans le cloner manuellement ?

```bash
curl -sL https：//raw.githubusercontent.com/SCFUCHS87/ansible/friend-setup/install_friend_setup.sh | bash
```

# Friend Setup ： Home Assistant + Homebridge (x86 via Ansible + Docker)

Ceci est un playbook Ansible minimal pour déployer Docker, Home Assistant et Homebridge sur un système Linux x86 propre. Il vérifie Docker, l'installe s'il manque, puis vous propose d'installer Home Assistant, Homebridge ou les deux.

---

## 📚 Table des Matières
- [Ce que cela fait](#ce-que-cela-fait)
- [Fichiers inclus](#fichiers-inclus)
- [Comment utiliser](#comment-utiliser)
- [Sortie](#sortie)
- [Prérequis](#prérequis)
- [Améliorations optionnelles](#améliorations-optionnelles)

---

## ✅ Ce que cela fait

- Installe Docker (s'il n'est pas déjà installé)
- Demande l'installation optionnelle de ：
  - [Home Assistant](https：//www.home-assistant.io/)
  - [Homebridge](https：//homebridge.io/)
- Déploie chaque service comme un conteneur Docker autonome avec des volumes persistants

---

## 📁 Fichiers inclus

```
inventory.friend.yml          # Inventaire avec hôte x86 cible
playbooks/friend_setup.yml    # Playbook qui demande et installe des rôles optionnels
roles/
├── base/                     # Préparation système optionnelle ou configuration utilisateur
├── docker/                   # Installation Docker si absent
├── homeassistant/           # Conteneur Docker pour Home Assistant
└── homebridge/              # Conteneur Docker pour Homebridge
site.yml                     # Point d'entrée pour tout
```

---

## 🚀 Comment utiliser

1. **Cloner le dépôt et basculer vers la branche `friend-setup` ：**
   ```bash
   git clone --branch friend-setup https：//github.com/SCFUCHS87/ansible.git
   cd ansible
   ```

2. **Modifier inventory.friend.yml avec l'IP et l'utilisateur de votre machine x86 ：**
   ```yaml
   all：
     hosts：
       ha-x86：
         ansible_host： 192.168.1.123
         ansible_user： votreutilisateur
   ```

3. **Exécuter le playbook ：**
   ```bash
   ansible-playbook -i inventory.friend.yml site.yml
   ```

4. **Répondre aux invites ：**
   - Installer Home Assistant ? (yes/no)
   - Installer Homebridge ? (yes/no)

---

## 🧾 Sortie

Si sélectionnés, les conteneurs suivants s'exécuteront ：

**Home Assistant**
- Accessible à ： http：//votre-ip：8123
- Données stockées dans ： /opt/homeassistant

**Homebridge**  
- Accessible à ： http：//votre-ip：8581
- Données stockées dans ： /opt/homebridge

Pour redémarrer, arrêter ou voir les logs, utilisez les commandes Docker standard.

---

## 🛠 Prérequis

- **Machine Linux x86 fraîche** (por exemplo, Ubuntu ou Debian)
- **Accès SSH** depuis votre machine de contrôle Ansible
- **Python + Ansible** installé sur la machine de contrôle ：
  ```bash
  sudo apt update && sudo apt install ansible
  ```

---

## 🧩 Améliorations optionnelles

Vous pouvez étendre cette configuration en ajoutant ：

- **Watchtower** — mises à jour automatiques des conteneurs Docker
- **Cloudflare Tunnel** — accès public sécurisé
- **Nginx Proxy Manager** — frontend pour proxy inverse + SSL
- **Intégration** avec MQTT, Node-RED ou Zigbee2MQTT

---

## 💬 Commentaires et Support

### 🐛 Vous avez trouvé un problème ?
[Signaler un bug ou un problème](https：//github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=support-request.md)

### 💡 Vous avez des commentaires ?
[Partagez votre expérience](https：//github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=friend-feedback.md)

### 💬 Questions générales ?
[Démarrer une discussion](https：//github.com/SCFUCHS87/ansible/discussions) ou envoyez un email directement !

### 📧 Contact direct
Vous préférez l'email ? Contactez-nous directement pour toute question ou suggestion.

---

### 🐧 Compatibilité des Distributions (Ubuntu, Debian, Fedora, Arch)

Cette configuration est maintenant compatible avec ：

| Distribution   | État    | Notes                                         |
|----------------|---------|-----------------------------------------------|
| Ubuntu 22.04+  | ✅ Fonctionne | Entièrement testé avec le script d'installation Docker |
| Debian 12+     | ✅ Fonctionne | Entièrement testé avec le script d'installation Docker |
| Fedora 38+     | ✅ Fonctionne | Utilise `dnf` natif pour installer Docker    |
| Arch Linux     | ✅ Fonctionne | Utilise `pacman` natif pour installer Docker |

Docker sera installé automatiquement en utilisant la méthode appropriée pour votre distribution ：
- Ubuntu/Debian ： via le script d'installation officiel de Docker
- Fedora ： via `dnf install docker docker-compose`
- Arch ： via `pacman -S docker`

Le playbook activera et démarrera également le service Docker.

---

### ⚠️ Notes pour les utilisateurs d'Arch et Fedora

- Assurez-vous que votre utilisateur est dans le groupe `docker` après l'installation ：
  ```bash
  sudo usermod -aG docker $USER
  ```
  Puis déconnectez-vous et reconnectez-vous, ou utilisez `newgrp docker`.

- Si Ansible ne peut pas gérer Docker après l'installation, vous pourriez avoir besoin de redémarrer ou de démarrer Docker manuellement avec ：
  ```bash
  sudo systemctl enable --now docker
  ```

---

💬 **Besoin d'aide ?**
Contactez la personne qui vous a donné ce dépôt ou ouvrez un issue sur GitHub.