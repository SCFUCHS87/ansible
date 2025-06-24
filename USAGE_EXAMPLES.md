# Friend Setup Usage Examples

## Basic Commands

### Full Setup
```bash
ansible-playbook -i inventory.friend.yml site.yml
```

### Dry Run (Check what would happen)
```bash
ansible-playbook -i inventory.friend.yml site.yml --check
```

### Verbose Output
```bash
ansible-playbook -i inventory.friend.yml site.yml -v
```

## Selective Installation

### Only Base System Setup
```bash
ansible-playbook -i inventory.friend.yml site.yml --tags base
```

### Only Docker Installation
```bash
ansible-playbook -i inventory.friend.yml site.yml --tags docker
```

### Only Home Assistant
```bash
ansible-playbook -i inventory.friend.yml site.yml --tags homeassistant
```

### Only Homebridge
```bash
ansible-playbook -i inventory.friend.yml site.yml --tags homebridge
```

## Maintenance Commands

### Update All Containers
```bash
ansible all -i inventory.friend.yml -m shell -a "docker pull ghcr.io/home-assistant/home-assistant:stable && docker restart homeassistant" --become
```

### Check Service Status
```bash
ansible all -i inventory.friend.yml -m shell -a "docker ps" --become
```

### View Container Logs
```bash
ansible all -i inventory.friend.yml -m shell -a "docker logs homeassistant --tail 50" --become
```

## Cleanup

### Remove Services
```bash
ansible-playbook -i inventory.friend.yml playbooks/cleanup.yml
```

### Manual Container Cleanup
```bash
ansible all -i inventory.friend.yml -m shell -a "docker stop homeassistant homebridge && docker rm homeassistant homebridge" --become
```

## Multiple Hosts

### Add multiple friends to inventory.friend.yml
```yaml
all:
  hosts:
    friend1:
      ansible_host: 192.168.1.100
      ansible_user: ubuntu
    friend2:
      ansible_host: 192.168.1.101
      ansible_user: pi
    friend3:
      ansible_host: 192.168.1.102
      ansible_user: debian
```

### Deploy to specific host
```bash
ansible-playbook -i inventory.friend.yml site.yml --limit friend1
```

### Deploy to multiple hosts
```bash
ansible-playbook -i inventory.friend.yml site.yml --limit "friend1,friend2"
```
