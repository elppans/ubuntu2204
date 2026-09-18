#!/usr/bin/env bash

# -- Diferença entre os 3 pacotes: ubuntu-gnome-desktop ubuntu-desktop ubuntu-desktop-minimal --
#
# ubuntu-desktop — o metapacote atual e "oficial" do Ubuntu. Instala a experiência completa: GNOME com as customizações/branding da Ubuntu, GDM, Firefox, LibreOffice, Thunderbird, Rhythmbox, GIMP e demais apps padrão. É o que a instalação normal do Ubuntu Desktop usa. Mais pesado (~4-5 GB, uso de RAM em torno de 1,2 GB).
# ubuntu-desktop-minimal — versão enxuta do mesmo GNOME com toque Ubuntu (mesmo GDM, gnome-shell, extensões da Ubuntu como o dock, nautilus), mas sem os aplicativos extras (sem LibreOffice, Firefox só como recomendado, etc). Pensado para quem quer um desktop funcional gastando menos espaço/recursos (~2-3 GB, ~800 MB RAM). É a base sobre a qual ubuntu-desktop se constrói (na verdade ubuntu-desktop depende de desktop-minimal).
# ubuntu-gnome-desktop — esse é um pacote legado/transicional. Até o Ubuntu 17.10 existia a flavor separada "Ubuntu GNOME" (quando o Ubuntu principal ainda usava Unity), e esse era o metapacote dela. Depois que o Ubuntu voltou a usar GNOME como padrão e a flavor Ubuntu GNOME foi descontinuada, esse pacote virou basicamente um pacote que depende de todos os pacotes do sistema desktop do Ubuntu — ou seja, hoje é praticamente equivalente/redundante a ubuntu-desktop, mantido só por compatibilidade com sistemas antigos. Não há motivo para instalá-lo num sistema novo. 
# https://community.linuxmint.com/software/view/ubuntu-gnome-desktop
#
# Na prática, hoje a escolha real é entre ubuntu-desktop (completo) e ubuntu-desktop-minimal (enxuto); ubuntu-gnome-desktop é resquício histórico.


# -- Diretório sources.list.d --
#!/bin/bash

DIR="/etc/apt/sources.list.d"
BACKUP_DIR="/etc/apt/sources.list.d-backup-$(date +%Y%m%d%H%M%S)"

# Verifica se o diretório existe e tem conteúdo
if [ -d "$DIR" ] && [ "$(ls -A $DIR)" ]; then
    echo "Fazendo backup do diretório \"$DIR\"..."
    
    # Cria o diretório de backup
    mkdir -p "$BACKUP_DIR"
    
    # Move os arquivos para o backup
    mv "$DIR"/* "$BACKUP_DIR"/
    
    echo "Backup concluído em $BACKUP_DIR."
    echo "Diretório $DIR foi esvaziado."
fi


# -- Arquivo sources.list --
sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup_"$(date +%Y%m%d%H%M)"

sudo tee /etc/apt/sources.list <<'EOF'
deb http://br.archive.ubuntu.com/ubuntu/ jammy main universe restricted
deb http://br.archive.ubuntu.com/ubuntu/ jammy-updates main universe restricted
deb http://br.archive.ubuntu.com/ubuntu/ jammy-security main universe restricted
EOF

# -- Pacotes do sistema --
sudo apt update
sudo apt --fix-broken install
sudo apt install --reinstall ubuntu-desktop-minimal gdm3 -y
sudo dpkg-reconfigure gdm3
sudo systemctl set-default graphical.target
sudo apt install -f
# sudo systemctl start gdm3
sudo apt upgrade -y
sudo apt clean
sudo apt autoclean
sudo apt autoremove

# sleep 15
sudo systemctl reboot -i
