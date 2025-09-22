#!/bin/bash

# Verifica se está rodando como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root (use sudo)." 
   exit 1
fi

echo "Criando o usuário 'qbit'..."
# Criar o usuário 'qbit' com diretório home
useradd -m -s /bin/bash qbit

# Adiciona o usuário ao grupo sudo
usermod -aG sudo qbit

# Define a senha do usuário 'qbit'
echo "Defina a senha para o usuário 'qbit':"
passwd qbit

echo "Atualizando repositórios..."
apt update

echo "Instalando o qBittorrent-nox..."
apt install -y qbittorrent-nox

echo "Iniciando qBittorrent-nox pela primeira vez..."
echo "⚠️  IMPORTANTE: Você precisa aceitar os termos de uso."
echo "🔹 Quando aparecer a mensagem 'Pressione Q para sair', pressione **Ctrl + C** para continuar a configuração."
echo "⏳ Iniciando qBittorrent-nox..."
sleep 3

# Executa o qBittorrent-nox como o usuário qbit para aceitar os termos
sudo -u qbit qbittorrent-nox

echo "Criando serviço systemd para execução automática..."

# Cria o arquivo do serviço
cat <<EOF > /etc/systemd/system/qbittorrent-nox.service
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
EOF

#Adiciona permissão ao usuário
chown qbit /home/qbit/

# Recarrega o systemd
systemctl daemon-reload

# Ativa o serviço para iniciar automaticamente no boot
systemctl enable qbittorrent-nox

# Inicia o serviço imediatamente
systemctl start qbittorrent-nox

echo "✅ qBittorrent-nox instalado e configurado com sucesso!"
echo "🌐 Acesse via navegador: http://<IP_DO_SERVIDOR>:8080"
echo "🔑 Usuário padrão: admin"
echo "🔒 Senha padrão: adminadmin (altere no primeiro login)"
