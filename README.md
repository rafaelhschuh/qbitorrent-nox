# 📥 Instalação do qBittorrent-nox

Este guia explica como instalar e configurar o **qBittorrent-nox** no Linux. Você pode optar pela instalação **manual** ou **automatizada**.

---

## 🚀 Instalação Automatizada

Para instalar o **qBittorrent-nox** rapidamente, basta rodar este comando:

```bash
sudo bash -c "$(wget -qLO - https://raw.githubusercontent.com/rafaelhschuh/qbitorrent-nox/refs/heads/main/install.sh)"
```

Esse comando fará o download e executará automaticamente o script de instalação.

---

## 🛠️ Instalação Manual  

Caso prefira instalar manualmente, siga os passos abaixo:

### 1️⃣ Criar um usuário para rodar o serviço  
```bash
sudo useradd -m -s /bin/bash qbit
sudo passwd qbit  # Defina uma senha para o usuário
sudo usermod -aG sudo qbit  # Adiciona ao grupo sudo
```

### 2️⃣ Atualizar pacotes e instalar o qBittorrent-nox  
```bash
sudo apt update
sudo apt install -y qbittorrent-nox
```

### 3️⃣ Iniciar qBittorrent-nox para aceitar os termos de uso  
```bash
sudo -u qbit qbittorrent-nox
```
**IMPORTANTE:** Quando aparecer a mensagem *"Pressione Q para sair"*, pressione **Ctrl + C**.

### 4️⃣ Criar um serviço systemd para iniciar automaticamente  
```bash
sudo nano /etc/systemd/system/qbittorrent-nox.service
```
Adicione o seguinte conteúdo:

```ini
[Unit]
Description=qBittorrent-nox Service
After=network.target

[Service]
User=qbit
ExecStart=/usr/bin/qbittorrent-nox
Restart=on-failure
WorkingDirectory=/home/qbit

[Install]
WantedBy=multi-user.target
```

Salve (`Ctrl + X`, `Y`, `Enter`) e execute:

```bash
sudo systemctl daemon-reload
sudo systemctl enable qbittorrent-nox
sudo systemctl start qbittorrent-nox
```

---

## 🌐 Acessando a Interface Web  

Após a instalação, acesse pelo navegador:

```
http://<IP_DO_SERVIDOR>:8080
```

**🔑 Credenciais padrão:**  
🆔 **Usuário:** `admin`  
🔒 **Senha:** `adminadmin` (altere no primeiro login)

Se precisar de mais ajustes, edite as configurações na interface web ou pelo arquivo de configuração.

---

## 🔧 Personalização  

- Para alterar a porta de acesso, modifique as configurações na interface web.  
- Logs e configurações ficam em `/home/qbit/.config/qBittorrent/`.  
- O serviço pode ser gerenciado com:
  ```bash
  sudo systemctl status qbittorrent-nox
  sudo systemctl restart qbittorrent-nox
  sudo systemctl stop qbittorrent-nox
  ```

---

🚀 **Agora é só aproveitar!** Caso tenha dúvidas, contribuições ou queira relatar problemas, abra uma [issue no GitHub](https://github.com/rafaelhschuh/qbitorrent-nox/issues).  
