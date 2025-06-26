FROM python:3.11-slim

WORKDIR /app

# Instalar locales y configurar es_ES.UTF-8
RUN apt-get update && apt-get install -y locales && \
    sed -i '/es_ES.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen es_ES.UTF-8 && \
    update-locale LANG=es_ES.UTF-8 LANGUAGE=es_ES:es LC_ALL=es_ES.UTF-8 && \
    apt-get clean

# Variables de entorno para locales
ENV LANG=es_ES.UTF-8
ENV LANGUAGE=es_ES:es
ENV LC_ALL=es_ES.UTF-8

# Copiar requirements e instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar código fuente
COPY . .

ENV FLASK_APP=main.py
ENV FLASK_ENV=development

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]
