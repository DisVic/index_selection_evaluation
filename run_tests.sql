-- ========================================================
-- Тест 1: Количество строк продаж
-- Ожидается: 2880404
-- ========================================================

-- Kimball (public)
SELECT 'Kimball' AS paradigm, 'Тест 1: Количество строк продаж' AS test, COUNT(*) AS result FROM public.store_sales;

-- Inmon (tpcds_inmon)
SELECT 'Inmon' AS paradigm, 'Тест 1: Количество строк продаж' AS test, COUNT(*) AS result FROM tpcds_inmon.store_sales;

-- Data Vault (tpcds_dv)
SELECT 'DataVault' AS paradigm, 'Тест 1: Количество строк продаж' AS test, COUNT(*) AS result FROM tpcds_dv.sat_store_sales;

-- ========================================================
-- Тест 2: Общая сумма продаж
-- Ожидается: 104231935.59
-- ========================================================

SELECT 'Kimball' AS paradigm, 'Тест 2: Общая сумма продаж' AS test, ROUND(SUM(ss_sales_price),2) AS result FROM public.store_sales;

SELECT 'Inmon' AS paradigm, 'Тест 2: Общая сумма продаж' AS test, ROUND(SUM(ss_sales_price),2) AS result FROM tpcds_inmon.store_sales;

SELECT 'DataVault' AS paradigm, 'Тест 2: Общая сумма продаж' AS test, ROUND(SUM((payload->>'ss_sales_price')::numeric),2) AS result FROM tpcds_dv.sat_store_sales;

-- ========================================================
-- Тест 3: Количество уникальных заказов (ticket_number)
-- Ожидается: 240000
-- ========================================================

SELECT 'Kimball' AS paradigm, 'Тест 3: Уникальные заказы' AS test, COUNT(DISTINCT ss_ticket_number) AS result FROM public.store_sales;

SELECT 'Inmon' AS paradigm, 'Тест 3: Уникальные заказы' AS test, COUNT(DISTINCT ss_ticket_number) AS result FROM tpcds_inmon.store_sales;

SELECT 'DataVault' AS paradigm, 'Тест 3: Уникальные заказы' AS test, COUNT(DISTINCT (payload->>'ss_ticket_number')::int) AS result FROM tpcds_dv.sat_store_sales;

-- ========================================================
-- Тест 4: Количество уникальных клиентов
-- Ожидается: 90858
-- ========================================================

SELECT 'Kimball' AS paradigm, 'Тест 4: Уникальные клиенты' AS test, COUNT(DISTINCT ss_customer_sk) AS result FROM public.store_sales;

SELECT 'Inmon' AS paradigm, 'Тест 4: Уникальные клиенты' AS test, COUNT(DISTINCT ss_customer_sk) AS result FROM tpcds_inmon.store_sales;

SELECT 'DataVault' AS paradigm, 'Тест 4: Уникальные клиенты' AS test, COUNT(DISTINCT hk_hub_customer_ss_customer_sk) AS result FROM tpcds_dv.link_store_sales;

-- ========================================================
-- Тест 5: Количество уникальных товаров
-- Ожидается: 18000
-- ========================================================

SELECT 'Kimball' AS paradigm, 'Тест 5: Уникальные товары' AS test, COUNT(DISTINCT ss_item_sk) AS result FROM public.store_sales;

SELECT 'Inmon' AS paradigm, 'Тест 5: Уникальные товары' AS test, COUNT(DISTINCT ss_item_sk) AS result FROM tpcds_inmon.store_sales;

SELECT 'DataVault' AS paradigm, 'Тест 5: Уникальные товары' AS test, COUNT(DISTINCT hk_hub_item_ss_item_sk) AS result FROM tpcds_dv.link_store_sales;

-- ========================================================
-- Тест 6: Средняя стоимость заказа
-- Ожидается: 434.30
-- ========================================================

SELECT 'Kimball' AS paradigm, 'Тест 6: Средняя стоимость заказа' AS test, ROUND(AVG(order_sum),2) AS result FROM (SELECT ss_ticket_number, SUM(ss_sales_price) AS order_sum FROM public.store_sales GROUP BY ss_ticket_number) t;

SELECT 'Inmon' AS paradigm, 'Тест 6: Средняя стоимость заказа' AS test, ROUND(AVG(order_sum),2) AS result FROM (SELECT ss_ticket_number, SUM(ss_sales_price) AS order_sum FROM tpcds_inmon.store_sales GROUP BY ss_ticket_number) t;

SELECT 'DataVault' AS paradigm, 'Тест 6: Средняя стоимость заказа' AS test, ROUND(AVG(order_sum),2) AS result FROM (SELECT (payload->>'ss_ticket_number')::int AS ticket, SUM((payload->>'ss_sales_price')::numeric) AS order_sum FROM tpcds_dv.sat_store_sales GROUP BY ticket) t;

-- ========================================================
-- Тест 7: Максимальная сумма одного заказа
-- Ожидается: 1227.61
-- ========================================================

SELECT 'Kimball' AS paradigm, 'Тест 7: Макс. сумма заказа' AS test, MAX(order_sum) AS result FROM (SELECT ss_ticket_number, SUM(ss_sales_price) AS order_sum FROM public.store_sales GROUP BY ss_ticket_number) t;

SELECT 'Inmon' AS paradigm, 'Тест 7: Макс. сумма заказа' AS test, MAX(order_sum) AS result FROM (SELECT ss_ticket_number, SUM(ss_sales_price) AS order_sum FROM tpcds_inmon.store_sales GROUP BY ss_ticket_number) t;

SELECT 'DataVault' AS paradigm, 'Тест 7: Макс. сумма заказа' AS test, MAX(order_sum) AS result FROM (SELECT (payload->>'ss_ticket_number')::int AS ticket, SUM((payload->>'ss_sales_price')::numeric) AS order_sum FROM tpcds_dv.sat_store_sales GROUP BY ticket) t;

-- ========================================================
-- Тест 8: Заказы с количеством > 5 ед. одного товара
-- Ожидается: 2612893
-- ========================================================

SELECT 'Kimball' AS paradigm, 'Тест 8: Заказы qty>5' AS test, COUNT(*) AS result FROM (SELECT ss_ticket_number, ss_item_sk, SUM(ss_quantity) AS total_qty FROM public.store_sales GROUP BY ss_ticket_number, ss_item_sk HAVING SUM(ss_quantity) > 5) t;

SELECT 'Inmon' AS paradigm, 'Тест 8: Заказы qty>5' AS test, COUNT(*) AS result FROM (SELECT ss_ticket_number, ss_item_sk, SUM(ss_quantity) AS total_qty FROM tpcds_inmon.store_sales GROUP BY ss_ticket_number, ss_item_sk HAVING SUM(ss_quantity) > 5) t;

SELECT 'DataVault' AS paradigm, 'Тест 8: Заказы qty>5' AS test, COUNT(*) AS result FROM (SELECT (payload->>'ss_ticket_number')::int AS ticket, (payload->>'ss_item_sk')::int AS item, SUM((payload->>'ss_quantity')::int) AS total_qty FROM tpcds_dv.sat_store_sales GROUP BY ticket, item HAVING SUM((payload->>'ss_quantity')::int) > 5) t;
