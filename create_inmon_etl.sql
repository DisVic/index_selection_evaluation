-- Item Hierarchy
INSERT INTO tpcds_inmon.category (i_category_id, i_category)
SELECT i_category_id, MAX(i_category) FROM public.item WHERE i_category_id IS NOT NULL GROUP BY i_category_id;

INSERT INTO tpcds_inmon.class (i_class_id, i_class, i_category_id)
SELECT i_class_id, MAX(i_class), MAX(i_category_id) FROM public.item WHERE i_class_id IS NOT NULL GROUP BY i_class_id;

INSERT INTO tpcds_inmon.brand (i_brand_id, i_brand, i_class_id)
SELECT i_brand_id, MAX(i_brand), MAX(i_class_id) FROM public.item WHERE i_brand_id IS NOT NULL GROUP BY i_brand_id;

INSERT INTO tpcds_inmon.manufact (i_manufact_id, i_manufact)
SELECT i_manufact_id, MAX(i_manufact) FROM public.item WHERE i_manufact_id IS NOT NULL GROUP BY i_manufact_id;

INSERT INTO tpcds_inmon.item
SELECT i_item_sk, i_item_id, i_rec_start_date, i_rec_end_date, i_item_desc, i_current_price, i_wholesale_cost, i_brand_id, i_manufact_id, i_size, i_formulation, i_color, i_units, i_container, i_manager_id, i_product_name
FROM public.item;

-- Store Hierarchy
INSERT INTO tpcds_inmon.company (company_id, company_name)
SELECT company_id, MAX(company_name) FROM (
    SELECT s_company_id as company_id, s_company_name as company_name FROM public.store WHERE s_company_id IS NOT NULL
    UNION ALL
    SELECT cc_company, cc_company_name FROM public.call_center WHERE cc_company IS NOT NULL
    UNION ALL
    SELECT web_company_id, web_company_name FROM public.web_site WHERE web_company_id IS NOT NULL
) as tmp
GROUP BY company_id;

INSERT INTO tpcds_inmon.division (division_id, division_name, company_id)
SELECT division_id, MAX(division_name), MAX(company_id) FROM (
    SELECT s_division_id as division_id, s_division_name as division_name, s_company_id as company_id FROM public.store WHERE s_division_id IS NOT NULL
    UNION ALL
    SELECT cc_division, cc_division_name, cc_company FROM public.call_center WHERE cc_division IS NOT NULL
) as tmp
GROUP BY division_id;

INSERT INTO tpcds_inmon.market (market_id, market_desc, market_manager)
SELECT market_id, MAX(market_desc), MAX(market_manager) FROM (
    SELECT s_market_id as market_id, s_market_desc as market_desc, s_market_manager as market_manager FROM public.store WHERE s_market_id IS NOT NULL
    UNION ALL
    SELECT cc_mkt_id, cc_mkt_desc, cc_market_manager FROM public.call_center WHERE cc_mkt_id IS NOT NULL
    UNION ALL
    SELECT web_mkt_id, web_mkt_desc, web_market_manager FROM public.web_site WHERE web_mkt_id IS NOT NULL
) as tmp
GROUP BY market_id;

INSERT INTO tpcds_inmon.store
SELECT s_store_sk, s_store_id, s_rec_start_date, s_rec_end_date, s_closed_date_sk, s_store_name, s_number_employees, s_floor_space, s_hours, s_manager, s_market_id, s_geography_class, s_division_id, s_street_number, s_street_name, s_street_type, s_suite_number, s_city, s_county, s_state, s_zip, s_country, s_gmt_offset, s_tax_precentage
FROM public.store;

INSERT INTO tpcds_inmon.web_site
SELECT web_site_sk, web_site_id, web_rec_start_date, web_rec_end_date, web_name, web_open_date_sk, web_close_date_sk, web_class, web_manager, web_mkt_id, web_mkt_class, web_company_id, web_street_number, web_street_name, web_street_type, web_suite_number, web_city, web_county, web_state, web_zip, web_country, web_gmt_offset, web_tax_percentage
FROM public.web_site;

INSERT INTO tpcds_inmon.call_center
SELECT cc_call_center_sk, cc_call_center_id, cc_rec_start_date, cc_rec_end_date, cc_closed_date_sk, cc_open_date_sk, cc_name, cc_class, cc_employees, cc_sq_ft, cc_hours, cc_manager, cc_mkt_id, cc_mkt_class, cc_division, cc_company, cc_street_number, cc_street_name, cc_street_type, cc_suite_number, cc_city, cc_county, cc_state, cc_zip, cc_country, cc_gmt_offset, cc_tax_percentage
FROM public.call_center;

-- Dimension direct copies
INSERT INTO tpcds_inmon.customer SELECT * FROM public.customer;
INSERT INTO tpcds_inmon.customer_address SELECT * FROM public.customer_address;
INSERT INTO tpcds_inmon.customer_demographics SELECT * FROM public.customer_demographics;
INSERT INTO tpcds_inmon.date_dim SELECT * FROM public.date_dim;
INSERT INTO tpcds_inmon.time_dim SELECT * FROM public.time_dim;
INSERT INTO tpcds_inmon.household_demographics SELECT * FROM public.household_demographics;
INSERT INTO tpcds_inmon.income_band SELECT * FROM public.income_band;
INSERT INTO tpcds_inmon.promotion SELECT * FROM public.promotion;
INSERT INTO tpcds_inmon.reason SELECT * FROM public.reason;
INSERT INTO tpcds_inmon.ship_mode SELECT * FROM public.ship_mode;
INSERT INTO tpcds_inmon.warehouse SELECT * FROM public.warehouse;
INSERT INTO tpcds_inmon.web_page SELECT * FROM public.web_page;
INSERT INTO tpcds_inmon.catalog_page SELECT * FROM public.catalog_page;

-- Fact table copies
INSERT INTO tpcds_inmon.store_sales SELECT * FROM public.store_sales;
INSERT INTO tpcds_inmon.store_returns SELECT * FROM public.store_returns;
INSERT INTO tpcds_inmon.catalog_sales SELECT * FROM public.catalog_sales;
INSERT INTO tpcds_inmon.catalog_returns SELECT * FROM public.catalog_returns;
INSERT INTO tpcds_inmon.web_sales SELECT * FROM public.web_sales;
INSERT INTO tpcds_inmon.web_returns SELECT * FROM public.web_returns;
INSERT INTO tpcds_inmon.inventory SELECT * FROM public.inventory;
