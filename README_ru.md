<div align="center">
  <img src="assets/logo.png" alt="AutoMTProxy" width="512">
<p>
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License">
  <img src="https://img.shields.io/badge/Language-Bash-4EAA25.svg?logo=gnu-bash&logoColor=white" alt="Bash">
  <img src="https://img.shields.io/badge/Tech-Docker-2496ED.svg?logo=docker&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/Release-v1.0.0-blueviolet.svg" alt="Version"></p>
<p align="center">
  <a href="https://github.com/Riffee/AutoMTProxy/blob/main/README.md">English</a> / 
  <strong>Русский</strong>
</p>
</div>

# О проекте 
<div>
  <p>
    <strong>AutoMTProxy</strong> — bash-скрипт, с помощью которого можно за несколько минут развернуть MTProto-прокси для
    <img src="https://upload.wikimedia.org/wikipedia/commons/8/82/Telegram_logo.svg" style="vertical-align: middle; height: 20px; width: 20px; margin-right: 2px;" alt="Telegram">
    <b>Telegram</b> в целях ускорения отправки/загрузки сообщений или медиафайлов в странах, где мессенджер замедлен.
  </p>
</div>

# Быстрый старт
```bash
mkdir -p AutoMTProxy && cd AutoMTProxy && curl -sO https://raw.githubusercontent.com/Riffee/AutoMTProxy/main/automtproxy.sh && chmod +x automtproxy.sh && ./automtproxy.sh
```

# Требования
* **ОС:** Ubuntu 20.04+ / Debian 10+
* **RAM:** 512 MB
* **SSD:** 5 GB
* **Зависимости:** curl, docker, docker-compose

# Ключевые возможности
* Автоматическая конфигурация за несколько шагов
* Выбор домена для маскировки трафика (FakeTLS)
* Генерация готовой ссылки для подключения сразу после установки

# Планируемые обновления
- [ ] Возможность выбора вида прокси (без или с поддержкой FakeTLS)
- [ ] Возможность добавить спонсорский канал в прокси
- [ ] Управление существующим Docker-контейнером с MTProto
- [ ] Случайный выбор порта
- [ ] Автоматическое обнаружение страны физического расположения сервера в целях автоматического выбора домена для маскировки
- [ ] Перевод скрипта на несколько языков (английский, русский, китайский и прочие)
