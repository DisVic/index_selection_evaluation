WITH item AS (
    SELECT i.i_item_sk, i.i_item_id, i.i_rec_start_date, i.i_rec_end_date, i.i_item_desc, i.i_current_price, i.i_wholesale_cost, i.i_size, i.i_formulation, i.i_color, i.i_units, i.i_container, i.i_manager_id, i.i_product_name,
           i.i_brand_id, b.i_class_id AS i_class_id, c.i_category_id AS i_category_id, i.i_manufact_id,
           b.i_brand, c.i_class, cat.i_category, m.i_manufact
    FROM tpcds_inmon.item i
    LEFT JOIN tpcds_inmon.brand b ON i.i_brand_id = b.i_brand_id
    LEFT JOIN tpcds_inmon.class c ON b.i_class_id = c.i_class_id
    LEFT JOIN tpcds_inmon.category cat ON c.i_category_id = cat.i_category_id
    LEFT JOIN tpcds_inmon.manufact m ON i.i_manufact_id = m.i_manufact_id
),
store AS (
    SELECT s.s_store_sk, s.s_store_id, s.s_rec_start_date, s.s_rec_end_date, s.s_closed_date_sk, s.s_store_name, s.s_number_employees, s.s_floor_space, s.s_hours, s.s_manager, s.s_geography_class, s.s_street_number, s.s_street_name, s.s_street_type, s.s_suite_number, s.s_city, s.s_county, s.s_state, s.s_zip, s.s_country, s.s_gmt_offset, s.s_tax_precentage,
           s.s_market_id, s.s_division_id, d.company_id AS s_company_id,
           m.market_desc as s_market_desc, m.market_manager as s_market_manager,
           d.division_name as s_division_name,
           c.company_name as s_company_name
    FROM tpcds_inmon.store s
    LEFT JOIN tpcds_inmon.market m ON s.s_market_id = m.market_id
    LEFT JOIN tpcds_inmon.division d ON s.s_division_id = d.division_id
    LEFT JOIN tpcds_inmon.company c ON d.company_id = c.company_id
),
call_center AS (
    SELECT cc.cc_call_center_sk, cc.cc_call_center_id, cc.cc_rec_start_date, cc.cc_rec_end_date, cc.cc_closed_date_sk, cc.cc_open_date_sk, cc.cc_name, cc.cc_class, cc.cc_employees, cc.cc_sq_ft, cc.cc_hours, cc.cc_manager, cc.cc_mkt_class, cc.cc_street_number, cc.cc_street_name, cc.cc_street_type, cc.cc_suite_number, cc.cc_city, cc.cc_county, cc.cc_state, cc.cc_zip, cc.cc_country, cc.cc_gmt_offset, cc.cc_tax_percentage,
           cc.cc_mkt_id, cc.cc_division, cc.cc_company,
           m.market_desc as cc_mkt_desc, m.market_manager as cc_market_manager,
           d.division_name as cc_division_name,
           co.company_name as cc_company_name
    FROM tpcds_inmon.call_center cc
    LEFT JOIN tpcds_inmon.market m ON cc.cc_mkt_id = m.market_id
    LEFT JOIN tpcds_inmon.division d ON cc.cc_division = d.division_id
    LEFT JOIN tpcds_inmon.company co ON cc.cc_company = co.company_id
),
web_site AS (
    SELECT ws.web_site_sk, ws.web_site_id, ws.web_rec_start_date, ws.web_rec_end_date, ws.web_name, ws.web_open_date_sk, ws.web_close_date_sk, ws.web_class, ws.web_manager, ws.web_mkt_class, ws.web_street_number, ws.web_street_name, ws.web_street_type, ws.web_suite_number, ws.web_city, ws.web_county, ws.web_state, ws.web_zip, ws.web_country, ws.web_gmt_offset, ws.web_tax_percentage,
           ws.web_mkt_id, ws.web_company_id,
           m.market_desc as web_mkt_desc, m.market_manager as web_market_manager,
           co.company_name as web_company_name
    FROM tpcds_inmon.web_site ws
    LEFT JOIN tpcds_inmon.market m ON ws.web_mkt_id = m.market_id
    LEFT JOIN tpcds_inmon.company co ON ws.web_company_id = co.company_id
)
select c_last_name
       ,c_first_name
       ,c_salutation
       ,c_preferred_cust_flag 
       ,ss_ticket_number
       ,cnt from
   (select ss_ticket_number
          ,ss_customer_sk
          ,count(*) cnt
    from store_sales,date_dim,store,household_demographics
    where store_sales.ss_sold_date_sk = date_dim.d_date_sk
    and store_sales.ss_store_sk = store.s_store_sk  
    and store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
    and date_dim.d_dom between 1 and 2 
    and (household_demographics.hd_buy_potential = '>10000' or
         household_demographics.hd_buy_potential = 'Unknown')
    and household_demographics.hd_vehicle_count > 0
    and case when household_demographics.hd_vehicle_count > 0 then 
             household_demographics.hd_dep_count/ household_demographics.hd_vehicle_count else null end > 1
    and date_dim.d_year in (1998,1998+1,1998+2)
    and store.s_county in ('Williamson County','Williamson County','Williamson County','Williamson County')
    group by ss_ticket_number,ss_customer_sk) dj,customer
    where ss_customer_sk = c_customer_sk
      and cnt between 1 and 5
    order by cnt desc, c_last_name asc;
