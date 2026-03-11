CREATE SCHEMA IF NOT EXISTS tpcds_dv;
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE TABLE tpcds_dv.hub_customer (
    hk_hub_customer bytea PRIMARY KEY,
    bk_customer varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_item (
    hk_hub_item bytea PRIMARY KEY,
    bk_item varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_store (
    hk_hub_store bytea PRIMARY KEY,
    bk_store varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_web_site (
    hk_hub_web_site bytea PRIMARY KEY,
    bk_web_site varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_call_center (
    hk_hub_call_center bytea PRIMARY KEY,
    bk_call_center varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_promotion (
    hk_hub_promotion bytea PRIMARY KEY,
    bk_promotion varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_warehouse (
    hk_hub_warehouse bytea PRIMARY KEY,
    bk_warehouse varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_catalog_page (
    hk_hub_catalog_page bytea PRIMARY KEY,
    bk_catalog_page varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_customer_address (
    hk_hub_customer_address bytea PRIMARY KEY,
    bk_customer_address varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_customer_demographics (
    hk_hub_customer_demographics bytea PRIMARY KEY,
    bk_customer_demographics varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_household_demographics (
    hk_hub_household_demographics bytea PRIMARY KEY,
    bk_household_demographics varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_date_dim (
    hk_hub_date_dim bytea PRIMARY KEY,
    bk_date_dim varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_time_dim (
    hk_hub_time_dim bytea PRIMARY KEY,
    bk_time_dim varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_income_band (
    hk_hub_income_band bytea PRIMARY KEY,
    bk_income_band varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_reason (
    hk_hub_reason bytea PRIMARY KEY,
    bk_reason varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_ship_mode (
    hk_hub_ship_mode bytea PRIMARY KEY,
    bk_ship_mode varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.hub_web_page (
    hk_hub_web_page bytea PRIMARY KEY,
    bk_web_page varchar(100),
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.link_store_sales (
    hk_link_store_sales bytea PRIMARY KEY,
    hk_hub_item_ss_item_sk bytea,
    hk_hub_customer_ss_customer_sk bytea,
    hk_hub_store_ss_store_sk bytea,
    hk_hub_promotion_ss_promo_sk bytea,
    hk_hub_customer_demographics_ss_cdemo_sk bytea,
    hk_hub_household_demographics_ss_hdemo_sk bytea,
    hk_hub_customer_address_ss_addr_sk bytea,
    hk_hub_date_dim_ss_sold_date_sk bytea,
    hk_hub_time_dim_ss_sold_time_sk bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.link_store_returns (
    hk_link_store_returns bytea PRIMARY KEY,
    hk_hub_item_sr_item_sk bytea,
    hk_hub_customer_sr_customer_sk bytea,
    hk_hub_store_sr_store_sk bytea,
    hk_hub_reason_sr_reason_sk bytea,
    hk_hub_customer_demographics_sr_cdemo_sk bytea,
    hk_hub_household_demographics_sr_hdemo_sk bytea,
    hk_hub_customer_address_sr_addr_sk bytea,
    hk_hub_date_dim_sr_returned_date_sk bytea,
    hk_hub_time_dim_sr_return_time_sk bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.link_catalog_sales (
    hk_link_catalog_sales bytea PRIMARY KEY,
    hk_hub_item_cs_item_sk bytea,
    hk_hub_customer_cs_bill_customer_sk bytea,
    hk_hub_customer_cs_ship_customer_sk bytea,
    hk_hub_call_center_cs_call_center_sk bytea,
    hk_hub_catalog_page_cs_catalog_page_sk bytea,
    hk_hub_ship_mode_cs_ship_mode_sk bytea,
    hk_hub_warehouse_cs_warehouse_sk bytea,
    hk_hub_promotion_cs_promo_sk bytea,
    hk_hub_date_dim_cs_sold_date_sk bytea,
    hk_hub_time_dim_cs_sold_time_sk bytea,
    hk_hub_customer_demographics_cs_bill_cdemo_sk bytea,
    hk_hub_household_demographics_cs_bill_hdemo_sk bytea,
    hk_hub_customer_address_cs_bill_addr_sk bytea,
    hk_hub_customer_demographics_cs_ship_cdemo_sk bytea,
    hk_hub_household_demographics_cs_ship_hdemo_sk bytea,
    hk_hub_customer_address_cs_ship_addr_sk bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.link_catalog_returns (
    hk_link_catalog_returns bytea PRIMARY KEY,
    hk_hub_item_cr_item_sk bytea,
    hk_hub_customer_cr_refunded_customer_sk bytea,
    hk_hub_customer_cr_returning_customer_sk bytea,
    hk_hub_call_center_cr_call_center_sk bytea,
    hk_hub_catalog_page_cr_catalog_page_sk bytea,
    hk_hub_ship_mode_cr_ship_mode_sk bytea,
    hk_hub_warehouse_cr_warehouse_sk bytea,
    hk_hub_reason_cr_reason_sk bytea,
    hk_hub_date_dim_cr_returned_date_sk bytea,
    hk_hub_time_dim_cr_returned_time_sk bytea,
    hk_hub_customer_demographics_cr_refunded_cdemo_sk bytea,
    hk_hub_household_demographics_cr_refunded_hdemo_sk bytea,
    hk_hub_customer_address_cr_refunded_addr_sk bytea,
    hk_hub_customer_demographics_cr_returning_cdemo_sk bytea,
    hk_hub_household_demographics_cr_returning_hdemo_sk bytea,
    hk_hub_customer_address_cr_returning_addr_sk bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.link_web_sales (
    hk_link_web_sales bytea PRIMARY KEY,
    hk_hub_item_ws_item_sk bytea,
    hk_hub_customer_ws_bill_customer_sk bytea,
    hk_hub_customer_ws_ship_customer_sk bytea,
    hk_hub_web_page_ws_web_page_sk bytea,
    hk_hub_web_site_ws_web_site_sk bytea,
    hk_hub_ship_mode_ws_ship_mode_sk bytea,
    hk_hub_warehouse_ws_warehouse_sk bytea,
    hk_hub_promotion_ws_promo_sk bytea,
    hk_hub_date_dim_ws_sold_date_sk bytea,
    hk_hub_time_dim_ws_sold_time_sk bytea,
    hk_hub_customer_demographics_ws_bill_cdemo_sk bytea,
    hk_hub_household_demographics_ws_bill_hdemo_sk bytea,
    hk_hub_customer_address_ws_bill_addr_sk bytea,
    hk_hub_customer_demographics_ws_ship_cdemo_sk bytea,
    hk_hub_household_demographics_ws_ship_hdemo_sk bytea,
    hk_hub_customer_address_ws_ship_addr_sk bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.link_web_returns (
    hk_link_web_returns bytea PRIMARY KEY,
    hk_hub_item_wr_item_sk bytea,
    hk_hub_customer_wr_refunded_customer_sk bytea,
    hk_hub_customer_wr_returning_customer_sk bytea,
    hk_hub_web_page_wr_web_page_sk bytea,
    hk_hub_reason_wr_reason_sk bytea,
    hk_hub_date_dim_wr_returned_date_sk bytea,
    hk_hub_time_dim_wr_returned_time_sk bytea,
    hk_hub_customer_demographics_wr_refunded_cdemo_sk bytea,
    hk_hub_household_demographics_wr_refunded_hdemo_sk bytea,
    hk_hub_customer_address_wr_refunded_addr_sk bytea,
    hk_hub_customer_demographics_wr_returning_cdemo_sk bytea,
    hk_hub_household_demographics_wr_returning_hdemo_sk bytea,
    hk_hub_customer_address_wr_returning_addr_sk bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.link_inventory (
    hk_link_inventory bytea PRIMARY KEY,
    hk_hub_date_dim_inv_date_sk bytea,
    hk_hub_item_inv_item_sk bytea,
    hk_hub_warehouse_inv_warehouse_sk bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS'
);
CREATE TABLE tpcds_dv.sat_customer (
    hk_hub_customer bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_customer, load_dts)
);
CREATE TABLE tpcds_dv.sat_item (
    hk_hub_item bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_item, load_dts)
);
CREATE TABLE tpcds_dv.sat_store (
    hk_hub_store bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_store, load_dts)
);
CREATE TABLE tpcds_dv.sat_web_site (
    hk_hub_web_site bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_web_site, load_dts)
);
CREATE TABLE tpcds_dv.sat_call_center (
    hk_hub_call_center bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_call_center, load_dts)
);
CREATE TABLE tpcds_dv.sat_promotion (
    hk_hub_promotion bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_promotion, load_dts)
);
CREATE TABLE tpcds_dv.sat_warehouse (
    hk_hub_warehouse bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_warehouse, load_dts)
);
CREATE TABLE tpcds_dv.sat_catalog_page (
    hk_hub_catalog_page bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_catalog_page, load_dts)
);
CREATE TABLE tpcds_dv.sat_customer_address (
    hk_hub_customer_address bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_customer_address, load_dts)
);
CREATE TABLE tpcds_dv.sat_customer_demographics (
    hk_hub_customer_demographics bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_customer_demographics, load_dts)
);
CREATE TABLE tpcds_dv.sat_household_demographics (
    hk_hub_household_demographics bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_household_demographics, load_dts)
);
CREATE TABLE tpcds_dv.sat_date_dim (
    hk_hub_date_dim bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_date_dim, load_dts)
);
CREATE TABLE tpcds_dv.sat_time_dim (
    hk_hub_time_dim bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_time_dim, load_dts)
);
CREATE TABLE tpcds_dv.sat_income_band (
    hk_hub_income_band bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_income_band, load_dts)
);
CREATE TABLE tpcds_dv.sat_reason (
    hk_hub_reason bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_reason, load_dts)
);
CREATE TABLE tpcds_dv.sat_ship_mode (
    hk_hub_ship_mode bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_ship_mode, load_dts)
);
CREATE TABLE tpcds_dv.sat_web_page (
    hk_hub_web_page bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_hub_web_page, load_dts)
);
CREATE TABLE tpcds_dv.sat_store_sales (
    hk_link_store_sales bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_link_store_sales, load_dts)
);
CREATE TABLE tpcds_dv.sat_store_returns (
    hk_link_store_returns bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_link_store_returns, load_dts)
);
CREATE TABLE tpcds_dv.sat_catalog_sales (
    hk_link_catalog_sales bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_link_catalog_sales, load_dts)
);
CREATE TABLE tpcds_dv.sat_catalog_returns (
    hk_link_catalog_returns bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_link_catalog_returns, load_dts)
);
CREATE TABLE tpcds_dv.sat_web_sales (
    hk_link_web_sales bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_link_web_sales, load_dts)
);
CREATE TABLE tpcds_dv.sat_web_returns (
    hk_link_web_returns bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_link_web_returns, load_dts)
);
CREATE TABLE tpcds_dv.sat_inventory (
    hk_link_inventory bytea,
    hash_diff bytea,
    load_dts timestamp DEFAULT now(),
    rec_src varchar(50) DEFAULT 'TPCDS',
    payload jsonb,
    PRIMARY KEY (hk_link_inventory, load_dts)
);