
> 🌍 Этот README также доступен на： [🇷🇺 Русский](translations/ru/readme.friendsetup.ru.md)

---

## 🧩 Установщик одной строкой (Опционально)

Хотите попробовать без ручного клонирования?

```bash
curl -sL https：//raw.githubusercontent.com/SCFUCHS87/ansible/friend-setup/install_friend_setup.sh | bash
```

# Friend Setup： Home Assistant + Homebridge (x86 через Ansible + Docker)

Это минимальный Ansible playbook для развертывания Docker, Home Assistant и Homebridge на чистой x86 Linux системе. Он проверяет Docker, устанавливает его при отсутствии, а затем спрашивает, хотите ли вы установить Home Assistant, Homebridge или оба.

---

## 📚 Содержание
- [Что это делает](#что-это-делает)
- [Включенные файлы](#включенные-файлы)
- [Как использовать](#как-использовать)
- [Вывод](#вывод)
- [Требования](#требования)
- [Опциональные улучшения](#опциональные-улучшения)

---

## ✅ Что это делает

- Устанавливает Docker (если он не установлен)
- Спрашивает об опциональной установке：
  - [Home Assistant](https：//www.home-assistant.io/)
  - [Homebridge](https：//homebridge.io/)
- Развертывает каждый сервис как отдельный Docker контейнер с постоянными томами

---

## 📁 Включенные файлы

```
inventory.friend.yml          # Инвентарь с целевым x86 хостом
playbooks/friend_setup.yml    # Playbook, который спрашивает и устанавливает опциональные роли
roles/
├── base/                     # Опциональная подготовка системы или настройка пользователя
├── docker/                   # Установка Docker, если отсутствует
├── homeassistant/           # Docker контейнер для Home Assistant
└── homebridge/              # Docker контейнер для Homebridge
site.yml                     # Точка входа для всего
```

---

## 🚀 Как использовать

1. **Клонировать репозиторий и переключиться на ветку `friend-setup`：**
   ```bash
   git clone --branch friend-setup https：//github.com/SCFUCHS87/ansible.git
   cd ansible
   ```

2. **Редактировать inventory.friend.yml с IP и пользователем вашей x86 машины：**
   ```yaml
   all：
     hosts：
       ha-x86：
         ansible_host： 192.168.1.123
         ansible_user： вашпользователь
   ```

3. **Запустить playbook：**
   ```bash
   ansible-playbook -i inventory.friend.yml site.yml
   ```

4. **Ответить на запросы：**
   - Установить Home Assistant? (yes/no)
   - Установить Homebridge? (yes/no)

---

## 🧾 Вывод

Если выбраны, будут запущены следующие контейнеры：

**Home Assistant**
- Доступен по адресу： http：//ваш-ip：8123
- Данные сохранены в： /opt/homeassistant

**Homebridge**  
- Доступен по адресу： http：//ваш-ip：8581
- Данные сохранены в： /opt/homebridge

Для перезапуска, остановки или просмотра логов используйте стандартные команды Docker.

---

## 🛠 Требования

- **Свежая x86 Linux машина** (например, Ubuntu, Debian)
- **SSH доступ** с вашей управляющей Ansible машины
- **Python + Ansible** установлены на управляющей машине：
  ```bash
  sudo apt update && sudo apt install ansible
  ```

---

## 🧩 Опциональные улучшения

Вы можете расширить эту настройку, добавив：

- **Watchtower** — автоматические обновления Docker контейнеров
- **Cloudflare Tunnel** — безопасный публичный доступ
- **Nginx Proxy Manager** — фронтенд для обратного прокси + SSL
- **Интеграция** с MQTT, Node-RED или Zigbee2MQTT

---

## 💬 Обратная связь и поддержка

### 🐛 Нашли проблему?
[Сообщить об ошибке или проблеме](https：//github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=support-request.md)

### 💡 Есть отзыв?
[Поделитесь своим опытом](https：//github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=friend-feedback.md)

### 💬 Общие вопросы?
[Начать обсуждение](https：//github.com/SCFUCHS87/ansible/discussions) или отправьте email напрямую!

### 📧 Прямой контакт
Предпочитаете email? Свяжитесь напрямую для любых вопросов или предложений.

---

### 🐧 Совместимость дистрибутивов (Ubuntu, Debian, Fedora, Arch)

Эта настройка теперь совместима с：

| Дистрибутив    | Статус  | Примечания                                    |
|----------------|---------|-----------------------------------------------|
| Ubuntu 22.04+  | ✅ Работает | Полностью протестировано со скриптом установки Docker |
| Debian 12+     | ✅ Работает | Полностью протестировано со скриптом установки Docker |
| Fedora 38+     | ✅ Работает | Использует нативный `dnf` для установки Docker |
| Arch Linux     | ✅ Работает | Использует нативный `pacman` для установки Docker |

Docker будет установлен автоматически используя подходящий метод для вашего дистрибутива：
- Ubuntu/Debian： через официальный скрипт установки Docker
- Fedora： через `dnf install docker docker-compose`
- Arch： через `pacman -S docker`

Playbook также включит и запустит сервис Docker.

---

### ⚠️ Примечания для пользователей Arch и Fedora

- Убедитесь, что ваш пользователь в группе `docker` после установки：
  ```bash
  sudo usermod -aG docker $USER
  ```
  Затем выйдите и войдите снова, или используйте `newgrp docker`.

- Если Ansible не может управлять Docker после установки, вам может понадобиться перезагрузка или ручной запуск Docker с：
  ```bash
  sudo systemctl enable --now docker
  ```

---

💬 **Нужна помощь?**
Свяжитесь с человеком, который дал вам этот репозиторий, или откройте issue на GitHub.

---

