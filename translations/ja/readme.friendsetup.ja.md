
> 🌍 このREADMEは次の言語でも利用できます:[🇯🇵 日本語](translations/ja/readme.friendsetup.ja.md)

---

## 🧩 ワンライナーインストーラー(オプション)

手動でクローンせずに試してみませんか?

```bash
curl -sL https://raw.githubusercontent.com/SCFUCHS87/ansible/friend-setup/install_friend_setup.sh | bash
```

# Friend Setup:Home Assistant + Homebridge(x86 via Ansible + Docker)

これは、クリーンなx86 LinuxシステムにDocker、Home Assistant、Homebridgeをデプロイするための最小限のAnsible playbookです。Dockerをチェックし、不足している場合はインストールし、Home Assistant、Homebridge、または両方をインストールするかどうかを尋ねます。

---

## 📚 目次
- [これが行うこと](#これが行うこと)
- [含まれるファイル](#含まれるファイル)
- [使用方法](#使用方法)
- [出力](#出力)
- [要件](#要件)
- [オプションの改善](#オプションの改善)

---

## ✅ これが行うこと

- Dockerをインストール(まだインストールされていない場合)
- オプションのインストールを尋ねます:
  - [Home Assistant](https://www.home-assistant.io/)
  - [Homebridge](https://homebridge.io/)
- 各サービスを永続ボリュームを持つ自己完結型Dockerコンテナとしてデプロイ

---

## 📁 含まれるファイル

```
inventory.friend.yml          # ターゲットx86ホスト付きのインベントリ
playbooks/friend_setup.yml    # プロンプトしてオプションのロールをインストールするplaybook
roles/
├── base/                     # オプションのシステム準備またはユーザー設定
├── docker/                   # Dockerインストール(存在しない場合)
├── homeassistant/           # Home Assistant用Dockerコンテナ
└── homebridge/              # Homebridge用Dockerコンテナ
site.yml                     # すべてのエントリポイント
```

---

## 🚀 使用方法

1. **リポジトリをクローンして`friend-setup`ブランチに切り替え:**
   ```bash
   git clone --branch friend-setup https://github.com/SCFUCHS87/ansible.git
   cd ansible
   ```

2. **x86マシンのIPとユーザーでinventory.friend.ymlを編集:**
   ```yaml
   all:
     hosts:
       ha-x86:
         ansible_host: 192.168.1.123
         ansible_user: あなたのユーザー名
   ```

3. **playbookを実行:**
   ```bash
   ansible-playbook -i inventory.friend.yml site.yml
   ```

4. **プロンプトに応答:**
   - Home Assistantをインストールしますか?(yes/no)
   - Homebridgeをインストールしますか?(yes/no)

---

## 🧾 出力

選択した場合、次のコンテナが実行されます:

**Home Assistant**
- アクセス可能:http://あなたのIP:8123
- データ保存先:/opt/homeassistant

**Homebridge**  
- アクセス可能:http://あなたのIP:8581
- データ保存先:/opt/homebridge

再起動、停止、またはログを表示するには、標準のDockerコマンドを使用してください。

---

## 🛠 要件

- **新しいx86 Linuxマシン**(例:Ubuntu、Debian)
- **Ansible制御マシンからのSSHアクセス**
- **制御マシンにPython + Ansibleがインストールされていること**:
  ```bash
  sudo apt update && sudo apt install ansible
  ```

---

## 🧩 オプションの改善

以下を追加してこのセットアップを拡張できます:

- **Watchtower** — Dockerコンテナの自動更新
- **Cloudflare Tunnel** — 安全なパブリックアクセス
- **Nginx Proxy Manager** — リバースプロキシ + SSLのフロントエンド
- **MQTT、Node-RED、またはZigbee2MQTTとの統合**

---

## 💬 フィードバックとサポート

### 🐛 問題を見つけましたか?
[バグまたは問題を報告](https://github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=support-request.md)

### 💡 フィードバックがありますか?
[体験を共有](https://github.com/SCFUCHS87/ansible/issues/new?labels=friend-setup&template=friend-feedback.md)

### 💬 一般的な質問?
[ディスカッションを開始](https://github.com/SCFUCHS87/ansible/discussions)または直接メールを送信！

### 📧 直接連絡
メールを希望しますか?質問や提案について直接お問い合わせください。

---

### 🐧 ディストリビューション互換性(Ubuntu、Debian、Fedora、Arch)

このセットアップは以下と互換性があります:

| ディストリビューション | ステータス | 注記                                          |
|----------------|---------|-----------------------------------------------|
| Ubuntu 22.04+  | ✅ 動作 | Dockerインストールスクリプトで完全にテスト済み     |
| Debian 12+     | ✅ 動作 | Dockerインストールスクリプトで完全にテスト済み     |
| Fedora 38+     | ✅ 動作 | ネイティブ`dnf`を使用してDockerをインストール      |
| Arch Linux     | ✅ 動作 | ネイティブ`pacman`を使用してDockerをインストール   |

Dockerはディストリビューションに適した方法を使用して自動的にインストールされます:
- Ubuntu/Debian:Dockerの公式インストールスクリプト経由
- Fedora:`dnf install docker docker-compose`経由
- Arch:`pacman -S docker`経由

playbookはDockerサービスも有効化・開始します。

---

### ⚠️ ArchとFedoraユーザーへの注意

- インストール後、ユーザーが`docker`グループに属していることを確認してください:
  ```bash
  sudo usermod -aG docker $USER
  ```
  その後、ログアウトして再ログインするか、`newgrp docker`を使用してください。

- インストール後にAnsibleがDockerを管理できない場合、再起動するか手動でDockerを開始する必要があるかもしれません:
  ```bash
  sudo systemctl enable --now docker
  ```

---

💬 **ヘルプが必要ですか?**
このリポジトリを提供した人に連絡するか、GitHubでissueを開いてください。

---

