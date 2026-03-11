#!/bin/bash
# deploy.sh - Скрипт автоматизированного развертывания БД TPC-DS
# Поддерживает Kimball, Inmon и Data Vault

set -e

DB_HOST="localhost"
DB_USER="tpcds"
DB_NAME="tpcds"
# Предполагается, что переменная PGPASSWORD уже задана, либо пароль сохранен в .pgpass
export PGPASSWORD="tpcds_password"

echo "=== 0. Распаковка данных ==="
if [ ! -d "tpcds_data_1" ]; then
    echo "Распаковка многотомного архива tpcds_data_1.zip..."
    if command -v 7z &> /dev/null; then
        7z x tpcds_data_1.zip -o.
    elif command -v 7za &> /dev/null; then
        7za x tpcds_data_1.zip -o.
    else
        echo "[ВНИМАНИЕ] Утилита 7z не найдена. Установите p7zip-full/p7zip или распакуйте архив вручную."
    fi
else
    echo "Папка tpcds_data_1 уже существует, пропуск распаковки."
fi

echo "=== 1. Запуск инфраструктуры PostgreSQL ==="
docker-compose up -d
echo "Ожидание старта базы данных..."
sleep 5

echo "=== 2. Схема Kimball (Базовая) ==="
echo "Создание DDL структуры Kimball..."
psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f tpcds-kit/tools/tpcds.sql

echo "Загрузка 1.3 ГБ сырых данных (load_data.sql)..."
psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f load_data.sql
echo "Оригинальная схема готова."

echo "=== 3. Схема Inmon (3NF) ==="
echo "Выполнение Inmon DDL..."
psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f create_inmon_ddl.sql

echo "Трансформация ELT Kimball -> Inmon..."
psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f create_inmon_etl.sql
echo "Схема Inmon 3NF загружена."

echo "=== 4. Схема Data Vault 2.0 ==="
echo "Выполнение Data Vault DDL..."
psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f dv_ddl.sql

echo "Трансформация ELT с JSONB Сателлитами..."
psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f dv_etl.sql
echo "Схема Data Vault загружена."

echo "=== Все схемы и данные успешно развернуты! ==="
