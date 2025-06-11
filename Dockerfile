# Используем базовый образ Debian
FROM debian:bullseye

# Указываем автора
LABEL maintainer="Daniil Fomin <DaSFomin@stud.kpfu.ru>"

# Устанавливаем нужные пакеты: nginx и PostgreSQL
RUN apt-get update && \
    apt-get install -y nginx postgresql && \
    apt-get clean

# Устанавливаем переменные окружения
ENV POSTGRES_DB=hw3_db \
    POSTGRES_USER=postgres \
    POSTGRES_PASSWORD=postgres

# Копируем кастомную конфигурацию nginx
COPY nginx.conf /etc/nginx/sites-available/default

# Добавляем HTML-файл
ADD index.html /var/www/html/index.html

# Создаём рабочую директорию
WORKDIR /var/www/html

# Открываем порты
EXPOSE 80 5432

# Создаем volume для данных PostgreSQL
VOLUME ["/var/lib/postgresql/data"]

# Создаем пользователя, чтобы не работать от root
RUN useradd -ms /bin/bash webuser
USER webuser

# Команда по умолчанию, которая запускается при старте контейнера
CMD ["/start.sh"]
