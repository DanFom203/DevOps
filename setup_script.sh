#!/bin/bash

# === Переменные ===
LOGFILE="./setup_dev_group.log"
GROUP="dev"

# === Логирование ===
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGFILE"
}

# === Получение пути до директории из ключа -d или интерактивно ===
while getopts "d:" opt; do
  case $opt in
    d) DIR_PATH="$OPTARG" ;;
    *) echo "Usage: $0 [-d <dir_path>]"; exit 1 ;;
  esac
done

if [ -z "$DIR_PATH" ]; then
    read -rp "Введите путь до директории, где будут создаваться рабочие каталоги: " DIR_PATH
fi

# === Проверка, что путь существует ===
if [ ! -d "$DIR_PATH" ]; then
    log "Директория $DIR_PATH не существует. Создаю..."
    mkdir -p "$DIR_PATH" || { log "Ошибка создания директории"; exit 1; }
fi

# === Создание группы dev ===
if ! getent group "$GROUP" > /dev/null; then
    log "Создаю группу $GROUP"
    groupadd "$GROUP"
else
    log "Группа $GROUP уже существует"
fi

# === Получение списка не системных пользователей (UID >= 1000, кроме nobody) ===
log "Получаю список не системных пользователей..."
USER_LIST=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd)

# === Добавление пользователей в группу dev ===
for user in $USER_LIST; do
    log "Добавляю пользователя $user в группу $GROUP"
    usermod -aG "$GROUP" "$user"
done

# === Настройка sudo без пароля для группы dev ===
SUDO_FILE="/etc/sudoers.d/dev_nopasswd"
if [ ! -f "$SUDO_FILE" ]; then
    echo "%$GROUP ALL=(ALL) NOPASSWD:ALL" > "$SUDO_FILE"
    chmod 440 "$SUDO_FILE"
    log "Добавлены права на sudo без пароля для группы $GROUP"
else
    log "Файл sudoers уже настроен"
fi

# === Создание рабочих директорий для пользователей ===
for user in $USER_LIST; do
    USER_DIR="${DIR_PATH}/${user}_workdir"
    if [ ! -d "$USER_DIR" ]; then
        mkdir "$USER_DIR"
        chown "$user:$user" "$USER_DIR"
        chmod 660 "$USER_DIR"
        setfacl -m g:$GROUP:r "$USER_DIR"
        log "Создана директория $USER_DIR с владельцем $user и доступом для $GROUP"
    else
        log "Директория $USER_DIR уже существует"
    fi
done

log "Готово!"
