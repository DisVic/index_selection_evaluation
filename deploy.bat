@echo off
setlocal enabledelayedexpansion
REM deploy.bat - Скрипт автоматизированного развертывания БД TPC-DS для Windows
REM Все SQL команды выполняются ИЗНУТРИ контейнера Docker.

SET CONTAINER=tpcds_postgres
SET DB_USER=tpcds
SET DB_NAME=tpcds

echo === 0. Распаковка данных ===
if not exist "tpcds_data_1\" (
    echo Распаковка многотомного архива tpcds_data_1.zip...
    SET "SEVEN_ZIP=C:\Program Files\7-Zip\7z.exe"
    if exist "!SEVEN_ZIP!" (
        "!SEVEN_ZIP!" x tpcds_data_1.zip -o.
    ) else (
        echo [ВНИМАНИЕ] 7-Zip не найден по стандартному пути.
        echo Пожалуйста, установите 7-Zip или распакуйте архив вручную.
        pause
        exit /b 1
    )
) else (
    echo Папка tpcds_data_1 уже существует, пропуск распаковки.
)

echo === 1. Запуск инфраструктуры PostgreSQL ===
docker-compose up -d
echo Ожидание готовности PostgreSQL...
:WAIT_PG
docker exec %CONTAINER% pg_isready -U %DB_USER% -d %DB_NAME% > NUL 2>&1
if errorlevel 1 (
    echo   Postgres еще не готов, ожидание...
    timeout /t 2 /nobreak > NUL
    goto WAIT_PG
)
echo PostgreSQL готов!

echo === 2. Схема Kimball (Базовая) ===
echo Создание DDL структуры Kimball...
docker exec -i %CONTAINER% psql -U %DB_USER% -d %DB_NAME% -f /sql/tpcds.sql
echo Загрузка 1.3 ГБ сырых данных...
docker exec -i %CONTAINER% psql -U %DB_USER% -d %DB_NAME% -f /sql/load_data.sql
echo Оригинальная схема Kimball готова.

echo === 3. Схема Inmon (3NF) ===
docker exec -i %CONTAINER% psql -U %DB_USER% -d %DB_NAME% -f /sql/create_inmon_ddl.sql
docker exec -i %CONTAINER% psql -U %DB_USER% -d %DB_NAME% -f /sql/create_inmon_etl.sql
echo Схема Inmon 3NF загружена.

echo === 4. Схема Data Vault 2.0 ===
docker exec -i %CONTAINER% psql -U %DB_USER% -d %DB_NAME% -f /sql/dv_ddl.sql
docker exec -i %CONTAINER% psql -U %DB_USER% -d %DB_NAME% -f /sql/dv_etl.sql
echo Схема Data Vault загружена.

echo === Все схемы и данные успешно развернуты! ===
pause
