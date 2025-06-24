> 🌍 Este README também está disponível em: [🇵🇹 Português](translations/pt/readme.friendsetup.pt.md)

---

## 🧩 Instalador de Uma Linha (Opcional)

Quer testar isso sem clonar manualmente?

```bash
curl -sL https://raw.githubusercontent.com/SCFUCHS87/ansible/friend-setup/install_friend_setup.sh | bash
```

# Friend Setup: Home Assistant + Homebridge (x86 via Ansible + Docker)

Este é um playbook Ansible mínimo para implantar Docker, Home Assistant e Homebridge em um sistema Linux x86 limpo. Ele verifica o Docker, instala se estiver ausente, e então pergunta se você quer instalar Home Assistant, Homebridge ou ambos.

---

## 📚 Índice
- [O que isso faz](#o-que-isso-faz)
- [Arquivos incluídos](#arquivos-incluídos)
- [Como usar](#como-usar)
- [Saída](#saída)
- [Requisitos](#requisitos)
- [Melhorias opcionais](#melhorias-opcionais)

---

## ✅ O que isso faz

- Instala Docker (se não estiver instalado)
- Pergunta sobre instalação opcional de:
  - [Home Assistant](https://www.home-assistant.io/)
  - [Homebridge](https://homebridge.io/)
- Implanta cada serviço como um contêiner Docker independente com volumes persistentes

---

## 📁 Arquivos incluídos

```
inventory.friend.yml          # Inventário com host x86 de destino
playbooks/friend_setup.yml    # Playbook que pergunta e instala roles opcionais
roles/
├── base/                     # Preparação opcional do sistema ou configuração do usuário
├── docker/                   # Instalação do Docker se não estiver presente
├── homeassistant/           # Contêiner Docker para Home Assistant
└── homebridge/              # Contêiner Docker para Homebridge
site.yml                     # Ponto de entrada para tudo
```

---

## 🚀 Como usar

1. **Clonar o repositório e mudar para a branch `friend-setup`:**
   ```bash
   git clone --branch friend-setup https://github.com/SCFUCHS87/ansible.git
   cd ansible
   ```

2. **Editar inventory.friend.yml com o IP e usuário da sua máquina x86:**
   ```yaml
   all:
     hosts:
       ha-x86:
         ansible_host: 192.168.1.123
         ansible_user: seuusuario
   ```

3. **Executar o playbook:**
   ```bash
   ansible-playbook -i inventory.friend.yml site.yml
   ```

4. **Responder às perguntas:**
   - Instalar Home Assistant? (yes/no)
   - Instalar Homebridge? (yes/no)

---

## 🧾 Saída

Se selecionados, os seguintes contêineres serão executados:

**Home Assistant**
- Acessível em: http://seu-ip:8123
- Dados armazenados em: /opt/homeassistant

**Homebridge**  
- Acessível em: http://seu-ip:8581
- Dados armazenados em: /opt/homebridge

Para reiniciar, parar ou ver logs, use comandos Docker padrão.

---

## 🛠 Requisitos

- **Máquina Linux x86 limpa** (ex. Ubuntu, Debian)
- **Acesso SSH** da sua máquina de controle Ansible
- **Python + Ansible** instalado na máquina de controle:
  ```bash
  sudo apt update && sudo apt install ansible
  ```

---

## 🧩 Melhorias opcionais

Você pode expandir esta configuração adicionando:

- **Watchtower** — atualizações automáticas de contêineres Docker
- **Cloudflare Tunnel** — acesso público seguro
- **Nginx Proxy Manager** — frontend para proxy reverso + SSL
- **Integração** com MQTT, Node-RED ou Zigbee2MQTT

---

## 💬 Feedback e Suporte

### 🐛 Encontrou um problema?
[Relatar um bug ou problema](https://github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=support-request.md)

### 💡 Tem feedback?
[Compartilhe sua experiência](https://github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=friend-feedback.md)

### 💬 Perguntas gerais?
[Iniciar uma discussão](https://github.com/SCFUCHS87/ansible/discussions) ou envie um email diretamente!

### 📧 Contato direto
Prefere email? Entre em contato diretamente para qualquer pergunta ou sugestão.

---

### 🐧 Compatibilidade de Distribuições (Ubuntu, Debian, Fedora, Arch)

Esta configuração agora é compatível com:

| Distribuição   | Status  | Notas                                         |
|----------------|---------|-----------------------------------------------|
| Ubuntu 22.04+  | ✅ Funciona | Totalmente testado com script de instalação Docker |
| Debian 12+     | ✅ Funciona | Totalmente testado com script de instalação Docker |
| Fedora 38+     | ✅ Funciona | Usa `dnf` nativo para instalar Docker        |
| Arch Linux     | ✅ Funciona | Usa `pacman` nativo para instalar Docker     |

Docker será instalado automaticamente usando o método apropriado para sua distribuição:
- Ubuntu/Debian: via script oficial de instalação do Docker
- Fedora: via `dnf install docker docker-compose`
- Arch: via `pacman -S docker`

O playbook também habilitará e iniciará o serviço Docker.

---

### ⚠️ Notas para usuários Arch e Fedora

- Certifique-se de que seu usuário está no grupo `docker` após a instalação:
  ```bash
  sudo usermod -aG docker $USER
  ```
  Então faça logout e login novamente, ou use `newgrp docker`.

- Se o Ansible não conseguir gerenciar o Docker após a instalação, você pode precisar reiniciar ou iniciar o Docker manualmente com:
  ```bash
  sudo systemctl enable --now docker
  ```

---

💬 **Precisa de ajuda?**
Entre em contato com a pessoa que lhe deu este repositório ou abra um issue no GitHub.