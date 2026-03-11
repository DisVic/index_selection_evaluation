@echo off
REM deploy.bat - Скрипт автоматизированного развертывания БД TPC-DS для Windows
REM Поддерживает Kimball, Inmon и Data Vault

SET DB_HOST=localhost
SET DB_USER=tpcds
SET DB_NAME=tpcds
SET PGPASSWORD=tpcds_password

echo === 0. Распаковка данных ===
if not exist "tpcds_data_1\" (
    echo Распаковка многотомного архива tpcds_data_1.zip...
    SET SEVEN_ZIP="C:\Program Files\7-Zip\7z.exe"
    if exist !SEVEN_ZIP! (
        !SEVEN_ZIP! x tpcds_data_1.zip -o.
    ) else (
        echo [ВНИМАНИЕ] 7-Zip не найден по стандартному пути.
        echo Пожалуйста, установите 7-Zip или распакуйте многотомный архив tpcds_data_1 вручную.
        pause
    )
) else (
    echo Папка tpcds_data_1 уже существует, пропуск распаковки.
)


echo === 1. Запуск инфраструктуры PostgreSQL ===
docker-compose up -d
echo Ожидание старта базы данных...
timeout /t 5 /nobreak > NUL

echo === 2. Схема Kimball (Базовая) ===
echo Создание DDL структуры Kimball...
psql -h %DB_HOST% -U %DB_USER% -d %DB_NAME% -f tpcds-kit/tools/tpcds.sql

echo Загрузка 1.3 ГБ сырых данных (load_data.sql)...
psql -h %DB_HOST% -U %DB_USER% -d %DB_NAME% -f load_data.sql
echo Оригинальная схема готова.

echo === 3. Схема Inmon (3NF) ===
echo Выполнение Inmon DDL...
psql -h %DB_HOST% -U %DB_USER% -d %DB_NAME% -f create_inmon_ddl.sql

echo Трансформация ELT Kimball -^> Inmon...
psql -h %DB_HOST% -U %DB_USER% -d %DB_NAME% -f create_inmon_etl.sql
echo Схема Inmon 3NF загружена.

echo === 4. Схема Data Vault 2.0 ===
echo Выполнение Data Vault DDL...
psql -h %DB_HOST% -U %DB_USER% -d %DB_NAME% -f dv_ddl.sql

echo Трансформация ELT с JSONB Сателлитами...
psql -h %DB_HOST% -U %DB_USER% -d %DB_NAME% -f dv_etl.sql
echo Схема Data Vault загружена.

echo === Все схемы и данные успешно развернуты! ===
pause
