> 🌍 Este README también está disponible en： [🇪🇸 Español](translations/readme.friendsetup.es.md)

---

## 🧩 Instalador de Una Línea (Opcional)

¿Quieres probarlo sin tener que clonar manualmente?

```bash
curl -sL https：//raw.githubusercontent.com/SCFUCHS87/ansible/friend-setup/install_friend_setup.sh | bash
```

# Friend Setup： Home Assistant + Homebridge (x86 vía Ansible + Docker)

Este es un playbook mínimo de Ansible para implementar Docker, Home Assistant y Homebridge en un sistema Linux x86 limpio. Verifica Docker, lo instala si falta, y luego te pregunta si quieres instalar Home Assistant, Homebridge o ambos.

---

## 📚 Tabla de Contenidos
- [Qué hace esto](#qué-hace-esto)
- [Archivos incluidos](#archivos-incluidos)
- [Cómo usar](#cómo-usar)
- [Salida](#salida)
- [Requisitos](#requisitos)
- [Mejoras opcionales](#mejoras-opcionales)

---

## ✅ Qué hace esto

- Instala Docker (si no está instalado)
- Pregunta por la instalación opcional de：
  - [Home Assistant](https：//www.home-assistant.io/)
  - [Homebridge](https：//homebridge.io/)
- Implementa cada servicio como un contenedor Docker independiente con volúmenes persistentes

---

## 📁 Archivos incluidos

```
inventory.friend.yml          # Inventario con host x86 objetivo
playbooks/friend_setup.yml    # Playbook que pregunta e instala roles opcionales
roles/
├── base/                     # Preparación opcional del sistema o configuración de usuario
├── docker/                   # Instalación de Docker si no está presente
├── homeassistant/           # Contenedor Docker para Home Assistant
└── homebridge/              # Contenedor Docker para Homebridge
site.yml                     # Punto de entrada para todo
```

---

## 🚀 Cómo usar

1. **Clona el repositorio y cambiar a la rama `friend-setup`：**
   ```bash
   git clone --branch friend-setup https：//github.com/SCFUCHS87/ansible.git
   cd ansible
   ```

2. **Editar inventory.friend.yml con la IP y usuario de tu máquina x86：**
   ```yaml
   all：
     hosts：
       ha-x86：
         ansible_host： 192.168.1.123
         ansible_user： tuusuario
   ```

3. **Ejecutar el playbook：**
   ```bash
   ansible-playbook -i inventory.friend.yml site.yml
   ```

4. **Responder a las preguntas：**
   - ¿Instalar Home Assistant? (yes/no)
   - ¿Instalar Homebridge? (yes/no)

---

## 🧾 Salida

Si se seleccionan, los siguientes contenedores se ejecutarán：

**Home Assistant**
- Accesible en： http：//tu-ip：8123
- Datos almacenados en： /opt/homeassistant

**Homebridge**  
- Accesible en： http：//tu-ip：8581
- Datos almacenados en： /opt/homebridge

Para reiniciar, detener o ver logs, usa comandos estándar de Docker.

---

## 🛠 Requisitos

- **Máquina Linux x86 nueva** (ej. Ubuntu, Debian)
- **Acceso SSH** desde tu máquina de control de Ansible
- **Python + Ansible** instalado en la máquina de control：
  ```bash
  sudo apt update && sudo apt install ansible
  ```

---

## 🧩 Mejoras opcionales

Puedes expandir esta configuración agregando：

- **Watchtower** — actualizaciones automáticas de contenedores Docker
- **Cloudflare Tunnel** — acceso público seguro
- **Nginx Proxy Manager** — frontend para proxy inverso + SSL
- **Integración** con MQTT, Node-RED o Zigbee2MQTT

---

## 💬 Comentarios y Soporte

### 🐛 ¿Encontraste un problema?
[Reportar un bug o problema](https：//github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=support-request.md)

### 💡 ¿Tienes comentarios?
[Comparte tu experiencia](https：//github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=friend-feedback.md)

### 💬 ¿Preguntas generales?
[Iniciar una discusión](https：//github.com/SCFUCHS87/ansible/discussions) o ¡envía un email directamente!

### 📧 Contacto directo
¿Prefieres email? Contáctanos directamente para cualquier pregunta o sugerencia.

---

### 🐧 Compatibilidad de Distribuciones (Ubuntu, Debian, Fedora, Arch)

Esta configuración ahora es compatible con：

| Distribución   | Estado  | Notas                                         |
|----------------|---------|-----------------------------------------------|
| Ubuntu 22.04+  | ✅ Funciona | Completamente probado con script de instalación Docker |
| Debian 12+     | ✅ Funciona | Completamente probado con script de instalación Docker |
| Fedora 38+     | ✅ Funciona | Usa `dnf` nativo para instalar Docker        |
| Arch Linux     | ✅ Funciona | Usa `pacman` nativo para instalar Docker     |

Docker se instalará automáticamente usando el método apropiado para tu distribución：
- Ubuntu/Debian： vía script oficial de instalación de Docker
- Fedora： vía `dnf install docker docker-compose`
- Arch： vía `pacman -S docker`

El playbook también habilitará e iniciará el servicio Docker.

---

### ⚠️ Notas para usuarios de Arch y Fedora

- Asegúrate de que tu usuario esté en el grupo `docker` después de la instalación：
  ```bash
  sudo usermod -aG docker $USER
  ```
  Luego cierra sesión y vuelve a entrar, o usa `newgrp docker`.

- Si Ansible no puede gestionar Docker después de la instalación, podrías necesitar reiniciar o iniciar Docker manualmente con：
  ```bash
  sudo systemctl enable --now docker
  ```

---

💬 **¿Necesitas ayuda?**
Contacta a la persona que te dio este repositorio o abre un issue en GitHub.