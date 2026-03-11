CREATE SCHEMA tpcds_inmon;

-- Item Hierarchy
CREATE TABLE tpcds_inmon.category (
    i_category_id integer PRIMARY KEY,
    i_category char(50)
);

CREATE TABLE tpcds_inmon.class (
    i_class_id integer PRIMARY KEY,
    i_class char(50),
    i_category_id integer REFERENCES tpcds_inmon.category(i_category_id)
);

CREATE TABLE tpcds_inmon.brand (
    i_brand_id integer PRIMARY KEY,
    i_brand char(50),
    i_class_id integer REFERENCES tpcds_inmon.class(i_class_id)
);

CREATE TABLE tpcds_inmon.manufact (
    i_manufact_id integer PRIMARY KEY,
    i_manufact char(50)
);

CREATE TABLE tpcds_inmon.item (
    i_item_sk integer PRIMARY KEY,
    i_item_id char(16),
    i_rec_start_date date,
    i_rec_end_date date,
    i_item_desc varchar(200),
    i_current_price decimal(7,2),
    i_wholesale_cost decimal(7,2),
    i_brand_id integer REFERENCES tpcds_inmon.brand(i_brand_id),
    i_manufact_id integer REFERENCES tpcds_inmon.manufact(i_manufact_id),
    i_size char(20),
    i_formulation char(20),
    i_color char(20),
    i_units char(10),
    i_container char(10),
    i_manager_id integer,
    i_product_name char(50)
);

-- Store Hierarchy
CREATE TABLE tpcds_inmon.company (
    company_id integer PRIMARY KEY,
    company_name varchar(50)
);

CREATE TABLE tpcds_inmon.division (
    division_id integer PRIMARY KEY,
    division_name varchar(50),
    company_id integer REFERENCES tpcds_inmon.company(company_id)
);

CREATE TABLE tpcds_inmon.market (
    market_id integer PRIMARY KEY,
    market_desc varchar(100),
    market_manager varchar(40)
);

CREATE TABLE tpcds_inmon.store (
    s_store_sk integer PRIMARY KEY,
    s_store_id char(16),
    s_rec_start_date date,
    s_rec_end_date date,
    s_closed_date_sk integer,
    s_store_name varchar(50),
    s_number_employees integer,
    s_floor_space integer,
    s_hours char(20),
    s_manager varchar(40),
    s_market_id integer REFERENCES tpcds_inmon.market(market_id),
    s_geography_class varchar(100),
    s_division_id integer REFERENCES tpcds_inmon.division(division_id),
    s_street_number varchar(10),
    s_street_name varchar(60),
    s_street_type char(15),
    s_suite_number char(10),
    s_city varchar(60),
    s_county varchar(30),
    s_state char(2),
    s_zip char(10),
    s_country varchar(20),
    s_gmt_offset decimal(5,2),
    s_tax_precentage decimal(5,2)
);

-- Web Site Hierarchy
CREATE TABLE tpcds_inmon.web_site (
    web_site_sk integer PRIMARY KEY,
    web_site_id char(16),
    web_rec_start_date date,
    web_rec_end_date date,
    web_name varchar(50),
    web_open_date_sk integer,
    web_close_date_sk integer,
    web_class varchar(50),
    web_manager varchar(40),
    web_mkt_id integer REFERENCES tpcds_inmon.market(market_id),
    web_mkt_class varchar(50),
    web_company_id integer REFERENCES tpcds_inmon.company(company_id),
    web_street_number char(10),
    web_street_name varchar(60),
    web_street_type char(15),
    web_suite_number char(10),
    web_city varchar(60),
    web_county varchar(30),
    web_state char(2),
    web_zip char(10),
    web_country varchar(20),
    web_gmt_offset decimal(5,2),
    web_tax_percentage decimal(5,2)
);

-- Call Center Hierarchy
CREATE TABLE tpcds_inmon.call_center (
    cc_call_center_sk integer PRIMARY KEY,
    cc_call_center_id char(16),
    cc_rec_start_date date,
    cc_rec_end_date date,
    cc_closed_date_sk integer,
    cc_open_date_sk integer,
    cc_name varchar(50),
    cc_class varchar(50),
    cc_employees integer,
    cc_sq_ft integer,
    cc_hours char(20),
    cc_manager varchar(40),
    cc_mkt_id integer REFERENCES tpcds_inmon.market(market_id),
    cc_mkt_class char(50),
    cc_division integer REFERENCES tpcds_inmon.division(division_id),
    cc_company integer REFERENCES tpcds_inmon.company(company_id),
    cc_street_number char(10),
    cc_street_name varchar(60),
    cc_street_type char(15),
    cc_suite_number char(10),
    cc_city varchar(60),
    cc_county varchar(30),
    cc_state char(2),
    cc_zip char(10),
    cc_country varchar(20),
    cc_gmt_offset decimal(5,2),
    cc_tax_percentage decimal(5,2)
);

-- Core tables unchanged, directly moved into tpcds_inmon (fully normalized already)
CREATE TABLE tpcds_inmon.customer AS SELECT * FROM public.customer WITH NO DATA;
ALTER TABLE tpcds_inmon.customer ADD PRIMARY KEY (c_customer_sk);

CREATE TABLE tpcds_inmon.customer_address AS SELECT * FROM public.customer_address WITH NO DATA;
ALTER TABLE tpcds_inmon.customer_address ADD PRIMARY KEY (ca_address_sk);

CREATE TABLE tpcds_inmon.customer_demographics AS SELECT * FROM public.customer_demographics WITH NO DATA;
ALTER TABLE tpcds_inmon.customer_demographics ADD PRIMARY KEY (cd_demo_sk);

CREATE TABLE tpcds_inmon.date_dim AS SELECT * FROM public.date_dim WITH NO DATA;
ALTER TABLE tpcds_inmon.date_dim ADD PRIMARY KEY (d_date_sk);

CREATE TABLE tpcds_inmon.time_dim AS SELECT * FROM public.time_dim WITH NO DATA;
ALTER TABLE tpcds_inmon.time_dim ADD PRIMARY KEY (t_time_sk);

CREATE TABLE tpcds_inmon.household_demographics AS SELECT * FROM public.household_demographics WITH NO DATA;
ALTER TABLE tpcds_inmon.household_demographics ADD PRIMARY KEY (hd_demo_sk);

CREATE TABLE tpcds_inmon.income_band AS SELECT * FROM public.income_band WITH NO DATA;
ALTER TABLE tpcds_inmon.income_band ADD PRIMARY KEY (ib_income_band_sk);

CREATE TABLE tpcds_inmon.promotion AS SELECT * FROM public.promotion WITH NO DATA;
ALTER TABLE tpcds_inmon.promotion ADD PRIMARY KEY (p_promo_sk);

CREATE TABLE tpcds_inmon.reason AS SELECT * FROM public.reason WITH NO DATA;
ALTER TABLE tpcds_inmon.reason ADD PRIMARY KEY (r_reason_sk);

CREATE TABLE tpcds_inmon.ship_mode AS SELECT * FROM public.ship_mode WITH NO DATA;
ALTER TABLE tpcds_inmon.ship_mode ADD PRIMARY KEY (sm_ship_mode_sk);

CREATE TABLE tpcds_inmon.warehouse AS SELECT * FROM public.warehouse WITH NO DATA;
ALTER TABLE tpcds_inmon.warehouse ADD PRIMARY KEY (w_warehouse_sk);

CREATE TABLE tpcds_inmon.web_page AS SELECT * FROM public.web_page WITH NO DATA;
ALTER TABLE tpcds_inmon.web_page ADD PRIMARY KEY (wp_web_page_sk);

CREATE TABLE tpcds_inmon.catalog_page AS SELECT * FROM public.catalog_page WITH NO DATA;
ALTER TABLE tpcds_inmon.catalog_page ADD PRIMARY KEY (cp_catalog_page_sk);

-- Fact tables
CREATE TABLE tpcds_inmon.store_sales AS SELECT * FROM public.store_sales WITH NO DATA;
ALTER TABLE tpcds_inmon.store_sales ADD PRIMARY KEY (ss_item_sk, ss_ticket_number);

CREATE TABLE tpcds_inmon.store_returns AS SELECT * FROM public.store_returns WITH NO DATA;
ALTER TABLE tpcds_inmon.store_returns ADD PRIMARY KEY (sr_item_sk, sr_ticket_number);

CREATE TABLE tpcds_inmon.catalog_sales AS SELECT * FROM public.catalog_sales WITH NO DATA;
ALTER TABLE tpcds_inmon.catalog_sales ADD PRIMARY KEY (cs_item_sk, cs_order_number);

CREATE TABLE tpcds_inmon.catalog_returns AS SELECT * FROM public.catalog_returns WITH NO DATA;
ALTER TABLE tpcds_inmon.catalog_returns ADD PRIMARY KEY (cr_item_sk, cr_order_number);

CREATE TABLE tpcds_inmon.web_sales AS SELECT * FROM public.web_sales WITH NO DATA;
ALTER TABLE tpcds_inmon.web_sales ADD PRIMARY KEY (ws_item_sk, ws_order_number);

CREATE TABLE tpcds_inmon.web_returns AS SELECT * FROM public.web_returns WITH NO DATA;
ALTER TABLE tpcds_inmon.web_returns ADD PRIMARY KEY (wr_item_sk, wr_order_number);

CREATE TABLE tpcds_inmon.inventory AS SELECT * FROM public.inventory WITH NO DATA;
ALTER TABLE tpcds_inmon.inventory ADD PRIMARY KEY (inv_date_sk, inv_item_sk, inv_warehouse_sk);

