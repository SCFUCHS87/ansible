> 🌍 Diese README ist auch verfügbar in: [🇩🇪 Deutsch](translations/readme.friendsetup.de.md)

---

## 🧩 Einzeilen-Installation (Optional)

Möchtest du das ausprobieren, ohne es manuell zu klonen?

```bash
curl -sL https://raw.githubusercontent.com/SCFUCHS87/ansible/friend-setup/install_friend_setup.sh | bash
```

# Friend Setup: Home Assistant + Homebridge (x86 über Ansible + Docker)

Dies ist ein minimales Ansible-Playbook zur Bereitstellung von Docker, Home Assistant und Homebridge auf einem sauberen x86-Linux-System. Es überprüft Docker, installiert es bei Bedarf und fragt dann, ob Home Assistant, Homebridge oder beide installiert werden sollen.

---

## 📚 Inhaltsverzeichnis
- [Was das macht](#was-das-macht)
- [Enthaltene Dateien](#enthaltene-dateien)
- [Verwendung](#verwendung)
- [Ausgabe](#ausgabe)
- [Voraussetzungen](#voraussetzungen)
- [Optionale Verbesserungen](#optionale-verbesserungen)

---

## ✅ Was das macht

- Installiert Docker (falls noch nicht installiert)
- Fragt nach optionaler Installation von:
  - [Home Assistant](https://www.home-assistant.io/)
  - [Homebridge](https://homebridge.io/)
- Stellt jeden Service als eigenständigen Docker-Container mit persistenten Volumes bereit

---

## 📁 Enthaltene Dateien

```
inventory.friend.yml          # Inventar mit Ziel-x86-Host
playbooks/friend_setup.yml    # Playbook, das fragt und optionale Rollen installiert
roles/
├── base/                     # Optionale Systemvorbereitung oder Benutzerkonfiguration
├── docker/                   # Docker-Installation falls nicht vorhanden
├── homeassistant/           # Docker-Container für Home Assistant
└── homebridge/              # Docker-Container für Homebridge
site.yml                     # Einstiegspunkt für alles
```

---

## 🚀 Verwendung

1. **Repository klonen und zum `friend-setup` Branch wechseln:**
   ```bash
   git clone --branch friend-setup https://github.com/SCFUCHS87/ansible.git
   cd ansible
   ```

2. **inventory.friend.yml mit der IP und dem Benutzer deiner x86-Maschine bearbeiten:**
   ```yaml
   all:
     hosts:
       ha-x86:
         ansible_host: 192.168.1.123
         ansible_user: deinbenutzer
   ```

3. **Das Playbook ausführen:**
   ```bash
   ansible-playbook -i inventory.friend.yml site.yml
   ```

4. **Auf die Aufforderungen antworten:**
   - Home Assistant installieren? (yes/no)
   - Homebridge installieren? (yes/no)

---

## 🧾 Ausgabe

Wenn ausgewählt, werden folgende Container laufen:

**Home Assistant**
- Erreichbar unter: http://deine-ip:8123
- Daten gespeichert unter: /opt/homeassistant

**Homebridge**  
- Erreichbar unter: http://deine-ip:8581
- Daten gespeichert unter: /opt/homebridge

Zum Neustarten, Stoppen oder Anzeigen der Logs verwende standard Docker-Befehle.

---

## 🛠 Voraussetzungen

- **Frische x86-Linux-Maschine** (z.B. Ubuntu, Debian)
- **SSH-Zugang** von deiner Ansible-Steuerungsmaschine
- **Python + Ansible** installiert auf der Steuerungsmaschine:
  ```bash
  sudo apt update && sudo apt install ansible
  ```

---

## 🧩 Optionale Verbesserungen

Du kannst dieses Setup erweitern durch:

- **Watchtower** — automatische Docker-Container-Updates
- **Cloudflare Tunnel** — sicherer öffentlicher Zugang
- **Nginx Proxy Manager** — Frontend für Reverse Proxy + SSL
- **Integration** mit MQTT, Node-RED oder Zigbee2MQTT

---

## 💬 Feedback & Support

### 🐛 Problem gefunden?
[Einen Bug oder ein Problem melden](https://github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=support-request.md)

### 💡 Hast du Feedback?
[Teile deine Erfahrung](https://github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=friend-feedback.md)

### 💬 Allgemeine Fragen?
[Starte eine Diskussion](https://github.com/SCFUCHS87/ansible/discussions) oder schreibe direkt eine E-Mail!

### 📧 Direkter Kontakt
Bevorzugst du E-Mail? Melde dich direkt für Fragen oder Vorschläge.

---

### 🐧 Distributions-Kompatibilität (Ubuntu, Debian, Fedora, Arch)

Dieses Setup ist jetzt kompatibel mit:

| Distribution   | Status  | Hinweise                                      |
|----------------|---------|-----------------------------------------------|
| Ubuntu 22.04+  | ✅ Funktioniert | Vollständig getestet mit Docker-Installationsskript |
| Debian 12+     | ✅ Funktioniert | Vollständig getestet mit Docker-Installationsskript |
| Fedora 38+     | ✅ Funktioniert | Verwendet natives `dnf` zur Docker-Installation |
| Arch Linux     | ✅ Funktioniert | Verwendet natives `pacman` zur Docker-Installation |

Docker wird automatisch mit der entsprechenden Methode für deine Distribution installiert:
- Ubuntu/Debian: über Dockers offizielles Installationsskript
- Fedora: über `dnf install docker docker-compose`
- Arch: über `pacman -S docker`

Das Playbook aktiviert und startet auch den Docker-Service.

---

### ⚠️ Hinweise für Arch- und Fedora-Benutzer

- Stelle sicher, dass dein Benutzer nach der Installation in der `docker` Gruppe ist:
  ```bash
  sudo usermod -aG docker $USER
  ```
  Dann melde dich ab und wieder an, oder verwende `newgrp docker`.

- Falls Ansible Docker nach der Installation nicht verwalten kann, musst du möglicherweise neu starten oder Docker manuell starten mit:
  ```bash
  sudo systemctl enable --now docker
  ```

---

💬 **Brauchst du Hilfe?**
Kontaktiere die Person, die dir dieses Repository gegeben hat, oder öffne ein Issue auf GitHub.