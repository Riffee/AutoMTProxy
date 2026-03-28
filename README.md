<div align="center">
  <img src="assets/logo.png" alt="AutoMTProxy" width="512">
<p>
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License">
  <img src="https://img.shields.io/badge/Language-Bash-4EAA25.svg?logo=gnu-bash&logoColor=white" alt="Bash">
  <img src="https://img.shields.io/badge/Tech-Docker-2496ED.svg?logo=docker&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/Release-v1.0.0-blueviolet.svg" alt="Version"></p>
<p align="center">
  <strong>English</strong> / 
  <a href="https://github.com/Riffee/AutoMTProxy/blob/main/README_ru.md">Русский</a>
</p>
</div>

# About the Project 
<div>
  <p>
    <strong>AutoMTProxy</strong> is a bash script designed to deploy an MTProto proxy for 
    <img src="https://upload.wikimedia.org/wikipedia/commons/8/82/Telegram_logo.svg" style="vertical-align: middle; height: 20px; width: 20px; margin-right: 2px;" alt="Telegram">
    <b>Telegram</b> in just a few minutes. It aims to improve message and media loading speeds in regions where the messenger is throttled or restricted.
  </p>
</div>

# Quick Start
```bash
mkdir -p AutoMTProxy && cd AutoMTProxy && curl -sO [https://raw.githubusercontent.com/Riffee/AutoMTProxy/main/automtproxy.sh](https://raw.githubusercontent.com/Riffee/AutoMTProxy/main/automtproxy.sh) && chmod +x automtproxy.sh && ./automtproxy.sh
```

# System Requirements
* OS: Ubuntu 20.04+ / Debian 10+
* RAM: 512 MB
* SSD: 5 GB
* Dependencies: curl, docker, docker-compose

# Key Features
* Automatic configuration in a few simple steps
* Domain selection for traffic obfuscation (FakeTLS)
* Auto-generated connection link immediately after installation

# Planned Updates
- [ ] Option to choose proxy type (with or without FakeTLS support)
- [ ] Ability to add a sponsorship channel to the proxy
- [ ] Manage existing MTProto Docker containers via script
- [ ] Randomized port selection
- [ ] Auto-detection of server's physical location for smart masking domain selection
- [ ] Multi-language script support (English, Russian, Chinese, etc.)
