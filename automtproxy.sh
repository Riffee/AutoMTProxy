#!/bin/bash

SERVER_IP=$(curl -s -4 ifconfig.me)

menu_header() {
    echo -e "\e[35;1m"
    cat <<'EOF'
  ______                                 __       __  ________  _______                         
 /      \                               |  \     |  \ |        \|       \                        
|  $$$$$$\ __    __  _| $$_     ______  | $$\   /  $$ \$$$$$$$$| $$$$$$$\  ______    ______   
| $$__| $$|  \  |  \|   $$ \   /      \ | $$$\ /  $$$   | $$   | $$__/ $$ /      \  /      \  
| $$    $$| $$  | $$ \$$$$$$  |  $$$$$$\| $$$$\  $$$$   | $$   | $$    $$|  $$$$$$\|  $$$$$$\ 
| $$$$$$$$| $$  | $$  | $$ __ | $$  | $$| $$\$$ $$ $$   | $$   | $$$$$$$ | $$    \$$| $$  | $$ 
| $$  | $$| $$__/ $$  | $$|  \| $$__/ $$| $$ \$$$| $$   | $$   | $$      | $$      | $$__/ $$ 
| $$  | $$ \$$    $$   \$$  $$ \$$    $$| $$  \$ | $$   | $$   | $$      | $$       \$$    $$ 
 \$$   \$$  \$$$$$$     \$$$$   \$$$$$$  \$$      \$$    \$$    \$$       \$$        \$$$$$$  
EOF
    echo -e "\e[0m"
}

install_docker() {
    if ! command -v docker &> /dev/null; then
        echo -e "Docker is not installed. Installing via get.docker.com..."
        curl -fsSL https://get.docker.com | sh
        sudo systemctl enable --now docker
    else
        echo -e "Docker is already installed."
    fi
    
    # Также проверим наличие xxd (нужен для генерации секрета)
    if ! command -v xxd &> /dev/null; then
        echo -e "Installing xxd..."
        sudo apt-get update && sudo apt-get install -y xxd
    fi
}

docker_check() {
    if [ "$(docker ps -aq -f name=^telemt$)" ]; then
        echo -e "${PURPLE}Warning:${NC} A container named 'telemt' already exists."
        read -p "Do you want to remove it and create a new one? (y/n): " confirm
        if [[ "$confirm" == [yY] ]]; then
            echo -e "${PURPLE}Removing old container...${NC}"
            docker rm -f telemt > /dev/null 2>&1
        else
            clear
            echo -e "Installation cancelled."
            exit 0
        fi
    fi
}

port_check() {
    local port=$1
    if ss -tuln | grep -q ":$port "; then
        echo -e "${PURPLE}Error:${NC} Port $port is already in use by another process!"
        echo -e "Please choose a different port or stop the service using it."
        exit 1
    else
        echo -e "${PURPLE}Port $port is available.${NC}"
    fi
}

data_collect() {
    clear
    menu_header
    docker_check
    
    clear
    menu_header
    while true; do
            echo -e "\n1. Enter Proxy Port (default 443): "
            read -p "> " PROXY_PORT
            PROXY_PORT=${PROXY_PORT:-443}
    
            if [[ "$PROXY_PORT" =~ ^[0-9]+$ ]]; then
                if [ "$PROXY_PORT" -gt 0 ] && [ "$PROXY_PORT" -le 65535 ]; then
                    port_check $PROXY_PORT
                    break
                else
                    echo -e "${PURPLE}Error:${NC} Port must be between 1 and 65535."
                fi
            else
                echo -e "${PURPLE}Error:${NC} Please enter digits only for the port."
            fi
        done
    
    clear
    menu_header
    while true; do
            echo -e "\n2. Enter FakeTLS Domain (default bild.de): "
            read -p "> " PROXY_DOMAIN
            PROXY_DOMAIN=${PROXY_DOMAIN:-bild.de}
    
            # Регулярное выражение: разрешены буквы, цифры, точки и дефисы. Запятые и прочее - мимо.
            if [[ "$PROXY_DOMAIN" =~ ^[a-zA-Z0-9.-]+$ ]]; then
                break
            else
                echo -e "${PURPLE}Error:${NC} Domain contains invalid characters (no commas, spaces or symbols allowed)."
            fi
        done
}

secrets_creation() {
    USER_SECRET=$(head -c 16 /dev/urandom | xxd -p | tr -d '\n')
    DOMAIN_HEX=$(echo -n "$PROXY_DOMAIN" | xxd -p | tr -d '\n')
    TELEGRAM_SECRET="ee${USER_SECRET}${DOMAIN_HEX}"
}

telemt_creation() {
    cat <<EOF > telemt.toml
show_link = ["docker"]
[general]
prefer_ipv6 = false
fast_mode = true
use_middle_proxy = false
[general.modes]
classic = false
secure = false
tls = true
[server]
port = $PROXY_PORT
listen_addr_ipv4 = "0.0.0.0"
[censorship]
tls_domain = "$PROXY_DOMAIN"
mask = true
mask_port = 443
fake_cert_len = 2048
[access.users]
docker = "$USER_SECRET"
[[upstreams]]
type = "direct"
enabled = true
EOF
}

dockerfile_creation() {
    cat <<EOF > docker-compose.yml
services:
  telemt:
    image: whn0thacked/telemt-docker:latest
    container_name: telemt
    restart: unless-stopped
    volumes:
      - ./telemt.toml:/etc/telemt.toml:ro
    ports:
      - "$PROXY_PORT:$PROXY_PORT/tcp"
    cap_add:
      - NET_BIND_SERVICE
    security_opt:
      - no-new-privileges:true
EOF
}

proxy_start() {
    docker compose up -d
    clear
}

result_proxy() {
    clear
    menu_header
    echo -e "\e[32mInstallation complete!\e[0m"
    echo -e "\nYour Proxy Link:\n"
    echo -e "tg://proxy?server=${SERVER_IP}&port=${PROXY_PORT}&secret=${TELEGRAM_SECRET}\n"
}

clear
menu_header
echo -e "Welcome to the Auto-MTProxy!\n"
echo -e "This script will help you install MTProxy on the server!\n"
echo -e "WARNING: THIS SCRIPT CANNOT MANAGE THIRD-PARTY CONTAINERS WITH MTProxy!!!\n"
read -p "Press ENTER to start the installation."

install_docker
data_collect
secrets_creation
telemt_creation
dockerfile_creation
proxy_start
result_proxy