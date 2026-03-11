#!/bin/bash
# deploy.sh - Скрипт автоматизированного развертывания БД TPC-DS
# Поддерживает Kimball, Inmon и Data Vault
# Все SQL команды выполняются ИЗНУТРИ контейнера Docker для избежания проблем с правами доступа.

set -e

CONTAINER="tpcds_postgres"
DB_USER="tpcds"
DB_NAME="tpcds"

# Функция для выполнения SQL файла внутри контейнера
run_sql() {
    echo "  -> Выполняю $1 ..."
    docker exec -i $CONTAINER psql -U $DB_USER -d $DB_NAME -f "$1"
}

echo "=== 0. Распаковка данных ==="
if [ ! -d "tpcds_data_1" ]; then
    echo "Распаковка многотомного архива tpcds_data_1.zip..."
    if command -v 7z &> /dev/null; then
        7z x tpcds_data_1.zip -o.
    elif command -v 7za &> /dev/null; then
        7za x tpcds_data_1.zip -o.
    else
        echo "[ВНИМАНИЕ] Утилита 7z не найдена. Установите p7zip-full/p7zip или распакуйте архив вручную."
        exit 1
    fi
else
    echo "Папка tpcds_data_1 уже существует, пропуск распаковки."
fi

echo "=== 1. Запуск инфраструктуры PostgreSQL ==="
docker-compose up -d
echo "Ожидание старта базы данных (15 сек)..."
sleep 15

echo "=== 2. Схема Kimball (Базовая) ==="
echo "DDL Kimball создается автоматически через docker-entrypoint-initdb.d"
echo "Загрузка 1.3 ГБ сырых данных..."
run_sql /sql/load_data.sql
echo "Оригинальная схема Kimball готова."

echo "=== 3. Схема Inmon (3NF) ==="
run_sql /sql/create_inmon_ddl.sql
run_sql /sql/create_inmon_etl.sql
echo "Схема Inmon 3NF загружена."

echo "=== 4. Схема Data Vault 2.0 ==="
run_sql /sql/dv_ddl.sql
run_sql /sql/dv_etl.sql
echo "Схема Data Vault загружена."

echo "=== Все схемы и данные успешно развернуты! ==="
