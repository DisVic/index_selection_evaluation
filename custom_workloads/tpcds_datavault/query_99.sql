WITH customer_address AS (
    SELECT 
        CAST(s.payload->>'ca_address_sk' AS integer) AS ca_address_sk,
        CAST(s.payload->>'ca_address_id' AS varchar) AS ca_address_id,
        CAST(s.payload->>'ca_street_number' AS varchar) AS ca_street_number,
        CAST(s.payload->>'ca_street_name' AS varchar) AS ca_street_name,
        CAST(s.payload->>'ca_street_type' AS varchar) AS ca_street_type,
        CAST(s.payload->>'ca_suite_number' AS varchar) AS ca_suite_number,
        CAST(s.payload->>'ca_city' AS varchar) AS ca_city,
        CAST(s.payload->>'ca_county' AS varchar) AS ca_county,
        CAST(s.payload->>'ca_state' AS varchar) AS ca_state,
        CAST(s.payload->>'ca_zip' AS varchar) AS ca_zip,
        CAST(s.payload->>'ca_country' AS varchar) AS ca_country,
        CAST(s.payload->>'ca_gmt_offset' AS numeric) AS ca_gmt_offset,
        CAST(s.payload->>'ca_location_type' AS varchar) AS ca_location_type
    FROM tpcds_dv.hub_customer_address h
    JOIN tpcds_dv.sat_customer_address s ON h.hk_hub_customer_address = s.hk_hub_customer_address
),
customer_demographics AS (
    SELECT 
        CAST(s.payload->>'cd_demo_sk' AS integer) AS cd_demo_sk,
        CAST(s.payload->>'cd_gender' AS varchar) AS cd_gender,
        CAST(s.payload->>'cd_marital_status' AS varchar) AS cd_marital_status,
        CAST(s.payload->>'cd_education_status' AS varchar) AS cd_education_status,
        CAST(s.payload->>'cd_purchase_estimate' AS integer) AS cd_purchase_estimate,
        CAST(s.payload->>'cd_credit_rating' AS varchar) AS cd_credit_rating,
        CAST(s.payload->>'cd_dep_count' AS integer) AS cd_dep_count,
        CAST(s.payload->>'cd_dep_employed_count' AS integer) AS cd_dep_employed_count,
        CAST(s.payload->>'cd_dep_college_count' AS integer) AS cd_dep_college_count
    FROM tpcds_dv.hub_customer_demographics h
    JOIN tpcds_dv.sat_customer_demographics s ON h.hk_hub_customer_demographics = s.hk_hub_customer_demographics
),
date_dim AS (
    SELECT 
        CAST(s.payload->>'d_date_sk' AS integer) AS d_date_sk,
        CAST(s.payload->>'d_date_id' AS varchar) AS d_date_id,
        CAST(s.payload->>'d_date' AS date) AS d_date,
        CAST(s.payload->>'d_month_seq' AS integer) AS d_month_seq,
        CAST(s.payload->>'d_week_seq' AS integer) AS d_week_seq,
        CAST(s.payload->>'d_quarter_seq' AS integer) AS d_quarter_seq,
        CAST(s.payload->>'d_year' AS integer) AS d_year,
        CAST(s.payload->>'d_dow' AS integer) AS d_dow,
        CAST(s.payload->>'d_moy' AS integer) AS d_moy,
        CAST(s.payload->>'d_dom' AS integer) AS d_dom,
        CAST(s.payload->>'d_qoy' AS integer) AS d_qoy,
        CAST(s.payload->>'d_fy_year' AS integer) AS d_fy_year,
        CAST(s.payload->>'d_fy_quarter_seq' AS integer) AS d_fy_quarter_seq,
        CAST(s.payload->>'d_fy_week_seq' AS integer) AS d_fy_week_seq,
        CAST(s.payload->>'d_day_name' AS varchar) AS d_day_name,
        CAST(s.payload->>'d_quarter_name' AS varchar) AS d_quarter_name,
        CAST(s.payload->>'d_holiday' AS varchar) AS d_holiday,
        CAST(s.payload->>'d_weekend' AS varchar) AS d_weekend,
        CAST(s.payload->>'d_following_holiday' AS varchar) AS d_following_holiday,
        CAST(s.payload->>'d_first_dom' AS integer) AS d_first_dom,
        CAST(s.payload->>'d_last_dom' AS integer) AS d_last_dom,
        CAST(s.payload->>'d_same_day_ly' AS integer) AS d_same_day_ly,
        CAST(s.payload->>'d_same_day_lq' AS integer) AS d_same_day_lq,
        CAST(s.payload->>'d_current_day' AS varchar) AS d_current_day,
        CAST(s.payload->>'d_current_week' AS varchar) AS d_current_week,
        CAST(s.payload->>'d_current_month' AS varchar) AS d_current_month,
        CAST(s.payload->>'d_current_quarter' AS varchar) AS d_current_quarter,
        CAST(s.payload->>'d_current_year' AS varchar) AS d_current_year
    FROM tpcds_dv.hub_date_dim h
    JOIN tpcds_dv.sat_date_dim s ON h.hk_hub_date_dim = s.hk_hub_date_dim
),
warehouse AS (
    SELECT 
        CAST(s.payload->>'w_warehouse_sk' AS integer) AS w_warehouse_sk,
        CAST(s.payload->>'w_warehouse_id' AS varchar) AS w_warehouse_id,
        CAST(s.payload->>'w_warehouse_name' AS varchar) AS w_warehouse_name,
        CAST(s.payload->>'w_warehouse_sq_ft' AS integer) AS w_warehouse_sq_ft,
        CAST(s.payload->>'w_street_number' AS varchar) AS w_street_number,
        CAST(s.payload->>'w_street_name' AS varchar) AS w_street_name,
        CAST(s.payload->>'w_street_type' AS varchar) AS w_street_type,
        CAST(s.payload->>'w_suite_number' AS varchar) AS w_suite_number,
        CAST(s.payload->>'w_city' AS varchar) AS w_city,
        CAST(s.payload->>'w_county' AS varchar) AS w_county,
        CAST(s.payload->>'w_state' AS varchar) AS w_state,
        CAST(s.payload->>'w_zip' AS varchar) AS w_zip,
        CAST(s.payload->>'w_country' AS varchar) AS w_country,
        CAST(s.payload->>'w_gmt_offset' AS numeric) AS w_gmt_offset
    FROM tpcds_dv.hub_warehouse h
    JOIN tpcds_dv.sat_warehouse s ON h.hk_hub_warehouse = s.hk_hub_warehouse
),
ship_mode AS (
    SELECT 
        CAST(s.payload->>'sm_ship_mode_sk' AS integer) AS sm_ship_mode_sk,
        CAST(s.payload->>'sm_ship_mode_id' AS varchar) AS sm_ship_mode_id,
        CAST(s.payload->>'sm_type' AS varchar) AS sm_type,
        CAST(s.payload->>'sm_code' AS varchar) AS sm_code,
        CAST(s.payload->>'sm_carrier' AS varchar) AS sm_carrier,
        CAST(s.payload->>'sm_contract' AS varchar) AS sm_contract
    FROM tpcds_dv.hub_ship_mode h
    JOIN tpcds_dv.sat_ship_mode s ON h.hk_hub_ship_mode = s.hk_hub_ship_mode
),
time_dim AS (
    SELECT 
        CAST(s.payload->>'t_time_sk' AS integer) AS t_time_sk,
        CAST(s.payload->>'t_time_id' AS varchar) AS t_time_id,
        CAST(s.payload->>'t_time' AS integer) AS t_time,
        CAST(s.payload->>'t_hour' AS integer) AS t_hour,
        CAST(s.payload->>'t_minute' AS integer) AS t_minute,
        CAST(s.payload->>'t_second' AS integer) AS t_second,
        CAST(s.payload->>'t_am_pm' AS varchar) AS t_am_pm,
        CAST(s.payload->>'t_shift' AS varchar) AS t_shift,
        CAST(s.payload->>'t_sub_shift' AS varchar) AS t_sub_shift,
        CAST(s.payload->>'t_meal_time' AS varchar) AS t_meal_time
    FROM tpcds_dv.hub_time_dim h
    JOIN tpcds_dv.sat_time_dim s ON h.hk_hub_time_dim = s.hk_hub_time_dim
),
reason AS (
    SELECT 
        CAST(s.payload->>'r_reason_sk' AS integer) AS r_reason_sk,
        CAST(s.payload->>'r_reason_id' AS varchar) AS r_reason_id,
        CAST(s.payload->>'r_reason_desc' AS varchar) AS r_reason_desc
    FROM tpcds_dv.hub_reason h
    JOIN tpcds_dv.sat_reason s ON h.hk_hub_reason = s.hk_hub_reason
),
income_band AS (
    SELECT 
        CAST(s.payload->>'ib_income_band_sk' AS integer) AS ib_income_band_sk,
        CAST(s.payload->>'ib_lower_bound' AS integer) AS ib_lower_bound,
        CAST(s.payload->>'ib_upper_bound' AS integer) AS ib_upper_bound
    FROM tpcds_dv.hub_income_band h
    JOIN tpcds_dv.sat_income_band s ON h.hk_hub_income_band = s.hk_hub_income_band
),
item AS (
    SELECT 
        CAST(s.payload->>'i_item_sk' AS integer) AS i_item_sk,
        CAST(s.payload->>'i_item_id' AS varchar) AS i_item_id,
        CAST(s.payload->>'i_rec_start_date' AS date) AS i_rec_start_date,
        CAST(s.payload->>'i_rec_end_date' AS date) AS i_rec_end_date,
        CAST(s.payload->>'i_item_desc' AS varchar) AS i_item_desc,
        CAST(s.payload->>'i_current_price' AS numeric) AS i_current_price,
        CAST(s.payload->>'i_wholesale_cost' AS numeric) AS i_wholesale_cost,
        CAST(s.payload->>'i_brand_id' AS integer) AS i_brand_id,
        CAST(s.payload->>'i_brand' AS varchar) AS i_brand,
        CAST(s.payload->>'i_class_id' AS integer) AS i_class_id,
        CAST(s.payload->>'i_class' AS varchar) AS i_class,
        CAST(s.payload->>'i_category_id' AS integer) AS i_category_id,
        CAST(s.payload->>'i_category' AS varchar) AS i_category,
        CAST(s.payload->>'i_manufact_id' AS integer) AS i_manufact_id,
        CAST(s.payload->>'i_manufact' AS varchar) AS i_manufact,
        CAST(s.payload->>'i_size' AS varchar) AS i_size,
        CAST(s.payload->>'i_formulation' AS varchar) AS i_formulation,
        CAST(s.payload->>'i_color' AS varchar) AS i_color,
        CAST(s.payload->>'i_units' AS varchar) AS i_units,
        CAST(s.payload->>'i_container' AS varchar) AS i_container,
        CAST(s.payload->>'i_manager_id' AS integer) AS i_manager_id,
        CAST(s.payload->>'i_product_name' AS varchar) AS i_product_name
    FROM tpcds_dv.hub_item h
    JOIN tpcds_dv.sat_item s ON h.hk_hub_item = s.hk_hub_item
),
store AS (
    SELECT 
        CAST(s.payload->>'s_store_sk' AS integer) AS s_store_sk,
        CAST(s.payload->>'s_store_id' AS varchar) AS s_store_id,
        CAST(s.payload->>'s_rec_start_date' AS date) AS s_rec_start_date,
        CAST(s.payload->>'s_rec_end_date' AS date) AS s_rec_end_date,
        CAST(s.payload->>'s_closed_date_sk' AS integer) AS s_closed_date_sk,
        CAST(s.payload->>'s_store_name' AS varchar) AS s_store_name,
        CAST(s.payload->>'s_number_employees' AS integer) AS s_number_employees,
        CAST(s.payload->>'s_floor_space' AS integer) AS s_floor_space,
        CAST(s.payload->>'s_hours' AS varchar) AS s_hours,
        CAST(s.payload->>'s_manager' AS varchar) AS s_manager,
        CAST(s.payload->>'s_market_id' AS integer) AS s_market_id,
        CAST(s.payload->>'s_geography_class' AS varchar) AS s_geography_class,
        CAST(s.payload->>'s_market_desc' AS varchar) AS s_market_desc,
        CAST(s.payload->>'s_market_manager' AS varchar) AS s_market_manager,
        CAST(s.payload->>'s_division_id' AS integer) AS s_division_id,
        CAST(s.payload->>'s_division_name' AS varchar) AS s_division_name,
        CAST(s.payload->>'s_company_id' AS integer) AS s_company_id,
        CAST(s.payload->>'s_company_name' AS varchar) AS s_company_name,
        CAST(s.payload->>'s_street_number' AS varchar) AS s_street_number,
        CAST(s.payload->>'s_street_name' AS varchar) AS s_street_name,
        CAST(s.payload->>'s_street_type' AS varchar) AS s_street_type,
        CAST(s.payload->>'s_suite_number' AS varchar) AS s_suite_number,
        CAST(s.payload->>'s_city' AS varchar) AS s_city,
        CAST(s.payload->>'s_county' AS varchar) AS s_county,
        CAST(s.payload->>'s_state' AS varchar) AS s_state,
        CAST(s.payload->>'s_zip' AS varchar) AS s_zip,
        CAST(s.payload->>'s_country' AS varchar) AS s_country,
        CAST(s.payload->>'s_gmt_offset' AS numeric) AS s_gmt_offset,
        CAST(s.payload->>'s_tax_precentage' AS numeric) AS s_tax_precentage
    FROM tpcds_dv.hub_store h
    JOIN tpcds_dv.sat_store s ON h.hk_hub_store = s.hk_hub_store
),
call_center AS (
    SELECT 
        CAST(s.payload->>'cc_call_center_sk' AS integer) AS cc_call_center_sk,
        CAST(s.payload->>'cc_call_center_id' AS varchar) AS cc_call_center_id,
        CAST(s.payload->>'cc_rec_start_date' AS date) AS cc_rec_start_date,
        CAST(s.payload->>'cc_rec_end_date' AS date) AS cc_rec_end_date,
        CAST(s.payload->>'cc_closed_date_sk' AS integer) AS cc_closed_date_sk,
        CAST(s.payload->>'cc_open_date_sk' AS integer) AS cc_open_date_sk,
        CAST(s.payload->>'cc_name' AS varchar) AS cc_name,
        CAST(s.payload->>'cc_class' AS varchar) AS cc_class,
        CAST(s.payload->>'cc_employees' AS integer) AS cc_employees,
        CAST(s.payload->>'cc_sq_ft' AS integer) AS cc_sq_ft,
        CAST(s.payload->>'cc_hours' AS varchar) AS cc_hours,
        CAST(s.payload->>'cc_manager' AS varchar) AS cc_manager,
        CAST(s.payload->>'cc_mkt_id' AS integer) AS cc_mkt_id,
        CAST(s.payload->>'cc_mkt_class' AS varchar) AS cc_mkt_class,
        CAST(s.payload->>'cc_mkt_desc' AS varchar) AS cc_mkt_desc,
        CAST(s.payload->>'cc_market_manager' AS varchar) AS cc_market_manager,
        CAST(s.payload->>'cc_division' AS integer) AS cc_division,
        CAST(s.payload->>'cc_division_name' AS varchar) AS cc_division_name,
        CAST(s.payload->>'cc_company' AS integer) AS cc_company,
        CAST(s.payload->>'cc_company_name' AS varchar) AS cc_company_name,
        CAST(s.payload->>'cc_street_number' AS varchar) AS cc_street_number,
        CAST(s.payload->>'cc_street_name' AS varchar) AS cc_street_name,
        CAST(s.payload->>'cc_street_type' AS varchar) AS cc_street_type,
        CAST(s.payload->>'cc_suite_number' AS varchar) AS cc_suite_number,
        CAST(s.payload->>'cc_city' AS varchar) AS cc_city,
        CAST(s.payload->>'cc_county' AS varchar) AS cc_county,
        CAST(s.payload->>'cc_state' AS varchar) AS cc_state,
        CAST(s.payload->>'cc_zip' AS varchar) AS cc_zip,
        CAST(s.payload->>'cc_country' AS varchar) AS cc_country,
        CAST(s.payload->>'cc_gmt_offset' AS numeric) AS cc_gmt_offset,
        CAST(s.payload->>'cc_tax_percentage' AS numeric) AS cc_tax_percentage
    FROM tpcds_dv.hub_call_center h
    JOIN tpcds_dv.sat_call_center s ON h.hk_hub_call_center = s.hk_hub_call_center
),
customer AS (
    SELECT 
        CAST(s.payload->>'c_customer_sk' AS integer) AS c_customer_sk,
        CAST(s.payload->>'c_customer_id' AS varchar) AS c_customer_id,
        CAST(s.payload->>'c_current_cdemo_sk' AS integer) AS c_current_cdemo_sk,
        CAST(s.payload->>'c_current_hdemo_sk' AS integer) AS c_current_hdemo_sk,
        CAST(s.payload->>'c_current_addr_sk' AS integer) AS c_current_addr_sk,
        CAST(s.payload->>'c_first_shipto_date_sk' AS integer) AS c_first_shipto_date_sk,
        CAST(s.payload->>'c_first_sales_date_sk' AS integer) AS c_first_sales_date_sk,
        CAST(s.payload->>'c_salutation' AS varchar) AS c_salutation,
        CAST(s.payload->>'c_first_name' AS varchar) AS c_first_name,
        CAST(s.payload->>'c_last_name' AS varchar) AS c_last_name,
        CAST(s.payload->>'c_preferred_cust_flag' AS varchar) AS c_preferred_cust_flag,
        CAST(s.payload->>'c_birth_day' AS integer) AS c_birth_day,
        CAST(s.payload->>'c_birth_month' AS integer) AS c_birth_month,
        CAST(s.payload->>'c_birth_year' AS integer) AS c_birth_year,
        CAST(s.payload->>'c_birth_country' AS varchar) AS c_birth_country,
        CAST(s.payload->>'c_login' AS varchar) AS c_login,
        CAST(s.payload->>'c_email_address' AS varchar) AS c_email_address,
        CAST(s.payload->>'c_last_review_date_sk' AS integer) AS c_last_review_date_sk
    FROM tpcds_dv.hub_customer h
    JOIN tpcds_dv.sat_customer s ON h.hk_hub_customer = s.hk_hub_customer
),
web_site AS (
    SELECT 
        CAST(s.payload->>'web_site_sk' AS integer) AS web_site_sk,
        CAST(s.payload->>'web_site_id' AS varchar) AS web_site_id,
        CAST(s.payload->>'web_rec_start_date' AS date) AS web_rec_start_date,
        CAST(s.payload->>'web_rec_end_date' AS date) AS web_rec_end_date,
        CAST(s.payload->>'web_name' AS varchar) AS web_name,
        CAST(s.payload->>'web_open_date_sk' AS integer) AS web_open_date_sk,
        CAST(s.payload->>'web_close_date_sk' AS integer) AS web_close_date_sk,
        CAST(s.payload->>'web_class' AS varchar) AS web_class,
        CAST(s.payload->>'web_manager' AS varchar) AS web_manager,
        CAST(s.payload->>'web_mkt_id' AS integer) AS web_mkt_id,
        CAST(s.payload->>'web_mkt_class' AS varchar) AS web_mkt_class,
        CAST(s.payload->>'web_mkt_desc' AS varchar) AS web_mkt_desc,
        CAST(s.payload->>'web_market_manager' AS varchar) AS web_market_manager,
        CAST(s.payload->>'web_company_id' AS integer) AS web_company_id,
        CAST(s.payload->>'web_company_name' AS varchar) AS web_company_name,
        CAST(s.payload->>'web_street_number' AS varchar) AS web_street_number,
        CAST(s.payload->>'web_street_name' AS varchar) AS web_street_name,
        CAST(s.payload->>'web_street_type' AS varchar) AS web_street_type,
        CAST(s.payload->>'web_suite_number' AS varchar) AS web_suite_number,
        CAST(s.payload->>'web_city' AS varchar) AS web_city,
        CAST(s.payload->>'web_county' AS varchar) AS web_county,
        CAST(s.payload->>'web_state' AS varchar) AS web_state,
        CAST(s.payload->>'web_zip' AS varchar) AS web_zip,
        CAST(s.payload->>'web_country' AS varchar) AS web_country,
        CAST(s.payload->>'web_gmt_offset' AS numeric) AS web_gmt_offset,
        CAST(s.payload->>'web_tax_percentage' AS numeric) AS web_tax_percentage
    FROM tpcds_dv.hub_web_site h
    JOIN tpcds_dv.sat_web_site s ON h.hk_hub_web_site = s.hk_hub_web_site
),
store_returns AS (
    SELECT 
        CAST(s.payload->>'sr_returned_date_sk' AS integer) AS sr_returned_date_sk,
        CAST(s.payload->>'sr_return_time_sk' AS integer) AS sr_return_time_sk,
        CAST(s.payload->>'sr_item_sk' AS integer) AS sr_item_sk,
        CAST(s.payload->>'sr_customer_sk' AS integer) AS sr_customer_sk,
        CAST(s.payload->>'sr_cdemo_sk' AS integer) AS sr_cdemo_sk,
        CAST(s.payload->>'sr_hdemo_sk' AS integer) AS sr_hdemo_sk,
        CAST(s.payload->>'sr_addr_sk' AS integer) AS sr_addr_sk,
        CAST(s.payload->>'sr_store_sk' AS integer) AS sr_store_sk,
        CAST(s.payload->>'sr_reason_sk' AS integer) AS sr_reason_sk,
        CAST(s.payload->>'sr_ticket_number' AS integer) AS sr_ticket_number,
        CAST(s.payload->>'sr_return_quantity' AS integer) AS sr_return_quantity,
        CAST(s.payload->>'sr_return_amt' AS numeric) AS sr_return_amt,
        CAST(s.payload->>'sr_return_tax' AS numeric) AS sr_return_tax,
        CAST(s.payload->>'sr_return_amt_inc_tax' AS numeric) AS sr_return_amt_inc_tax,
        CAST(s.payload->>'sr_fee' AS numeric) AS sr_fee,
        CAST(s.payload->>'sr_return_ship_cost' AS numeric) AS sr_return_ship_cost,
        CAST(s.payload->>'sr_refunded_cash' AS numeric) AS sr_refunded_cash,
        CAST(s.payload->>'sr_reversed_charge' AS numeric) AS sr_reversed_charge,
        CAST(s.payload->>'sr_store_credit' AS numeric) AS sr_store_credit,
        CAST(s.payload->>'sr_net_loss' AS numeric) AS sr_net_loss
    FROM tpcds_dv.link_store_returns l
    JOIN tpcds_dv.sat_store_returns s ON l.hk_link_store_returns = s.hk_link_store_returns
),
household_demographics AS (
    SELECT 
        CAST(s.payload->>'hd_demo_sk' AS integer) AS hd_demo_sk,
        CAST(s.payload->>'hd_income_band_sk' AS integer) AS hd_income_band_sk,
        CAST(s.payload->>'hd_buy_potential' AS varchar) AS hd_buy_potential,
        CAST(s.payload->>'hd_dep_count' AS integer) AS hd_dep_count,
        CAST(s.payload->>'hd_vehicle_count' AS integer) AS hd_vehicle_count
    FROM tpcds_dv.hub_household_demographics h
    JOIN tpcds_dv.sat_household_demographics s ON h.hk_hub_household_demographics = s.hk_hub_household_demographics
),
web_page AS (
    SELECT 
        CAST(s.payload->>'wp_web_page_sk' AS integer) AS wp_web_page_sk,
        CAST(s.payload->>'wp_web_page_id' AS varchar) AS wp_web_page_id,
        CAST(s.payload->>'wp_rec_start_date' AS date) AS wp_rec_start_date,
        CAST(s.payload->>'wp_rec_end_date' AS date) AS wp_rec_end_date,
        CAST(s.payload->>'wp_creation_date_sk' AS integer) AS wp_creation_date_sk,
        CAST(s.payload->>'wp_access_date_sk' AS integer) AS wp_access_date_sk,
        CAST(s.payload->>'wp_autogen_flag' AS varchar) AS wp_autogen_flag,
        CAST(s.payload->>'wp_customer_sk' AS integer) AS wp_customer_sk,
        CAST(s.payload->>'wp_url' AS varchar) AS wp_url,
        CAST(s.payload->>'wp_type' AS varchar) AS wp_type,
        CAST(s.payload->>'wp_char_count' AS integer) AS wp_char_count,
        CAST(s.payload->>'wp_link_count' AS integer) AS wp_link_count,
        CAST(s.payload->>'wp_image_count' AS integer) AS wp_image_count,
        CAST(s.payload->>'wp_max_ad_count' AS integer) AS wp_max_ad_count
    FROM tpcds_dv.hub_web_page h
    JOIN tpcds_dv.sat_web_page s ON h.hk_hub_web_page = s.hk_hub_web_page
),
promotion AS (
    SELECT 
        CAST(s.payload->>'p_promo_sk' AS integer) AS p_promo_sk,
        CAST(s.payload->>'p_promo_id' AS varchar) AS p_promo_id,
        CAST(s.payload->>'p_start_date_sk' AS integer) AS p_start_date_sk,
        CAST(s.payload->>'p_end_date_sk' AS integer) AS p_end_date_sk,
        CAST(s.payload->>'p_item_sk' AS integer) AS p_item_sk,
        CAST(s.payload->>'p_cost' AS numeric) AS p_cost,
        CAST(s.payload->>'p_response_target' AS integer) AS p_response_target,
        CAST(s.payload->>'p_promo_name' AS varchar) AS p_promo_name,
        CAST(s.payload->>'p_channel_dmail' AS varchar) AS p_channel_dmail,
        CAST(s.payload->>'p_channel_email' AS varchar) AS p_channel_email,
        CAST(s.payload->>'p_channel_catalog' AS varchar) AS p_channel_catalog,
        CAST(s.payload->>'p_channel_tv' AS varchar) AS p_channel_tv,
        CAST(s.payload->>'p_channel_radio' AS varchar) AS p_channel_radio,
        CAST(s.payload->>'p_channel_press' AS varchar) AS p_channel_press,
        CAST(s.payload->>'p_channel_event' AS varchar) AS p_channel_event,
        CAST(s.payload->>'p_channel_demo' AS varchar) AS p_channel_demo,
        CAST(s.payload->>'p_channel_details' AS varchar) AS p_channel_details,
        CAST(s.payload->>'p_purpose' AS varchar) AS p_purpose,
        CAST(s.payload->>'p_discount_active' AS varchar) AS p_discount_active
    FROM tpcds_dv.hub_promotion h
    JOIN tpcds_dv.sat_promotion s ON h.hk_hub_promotion = s.hk_hub_promotion
),
catalog_page AS (
    SELECT 
        CAST(s.payload->>'cp_catalog_page_sk' AS integer) AS cp_catalog_page_sk,
        CAST(s.payload->>'cp_catalog_page_id' AS varchar) AS cp_catalog_page_id,
        CAST(s.payload->>'cp_start_date_sk' AS integer) AS cp_start_date_sk,
        CAST(s.payload->>'cp_end_date_sk' AS integer) AS cp_end_date_sk,
        CAST(s.payload->>'cp_department' AS varchar) AS cp_department,
        CAST(s.payload->>'cp_catalog_number' AS integer) AS cp_catalog_number,
        CAST(s.payload->>'cp_catalog_page_number' AS integer) AS cp_catalog_page_number,
        CAST(s.payload->>'cp_description' AS varchar) AS cp_description,
        CAST(s.payload->>'cp_type' AS varchar) AS cp_type
    FROM tpcds_dv.hub_catalog_page h
    JOIN tpcds_dv.sat_catalog_page s ON h.hk_hub_catalog_page = s.hk_hub_catalog_page
),
inventory AS (
    SELECT 
        CAST(s.payload->>'inv_date_sk' AS integer) AS inv_date_sk,
        CAST(s.payload->>'inv_item_sk' AS integer) AS inv_item_sk,
        CAST(s.payload->>'inv_warehouse_sk' AS integer) AS inv_warehouse_sk,
        CAST(s.payload->>'inv_quantity_on_hand' AS integer) AS inv_quantity_on_hand
    FROM tpcds_dv.link_inventory l
    JOIN tpcds_dv.sat_inventory s ON l.hk_link_inventory = s.hk_link_inventory
),
catalog_returns AS (
    SELECT 
        CAST(s.payload->>'cr_returned_date_sk' AS integer) AS cr_returned_date_sk,
        CAST(s.payload->>'cr_returned_time_sk' AS integer) AS cr_returned_time_sk,
        CAST(s.payload->>'cr_item_sk' AS integer) AS cr_item_sk,
        CAST(s.payload->>'cr_refunded_customer_sk' AS integer) AS cr_refunded_customer_sk,
        CAST(s.payload->>'cr_refunded_cdemo_sk' AS integer) AS cr_refunded_cdemo_sk,
        CAST(s.payload->>'cr_refunded_hdemo_sk' AS integer) AS cr_refunded_hdemo_sk,
        CAST(s.payload->>'cr_refunded_addr_sk' AS integer) AS cr_refunded_addr_sk,
        CAST(s.payload->>'cr_returning_customer_sk' AS integer) AS cr_returning_customer_sk,
        CAST(s.payload->>'cr_returning_cdemo_sk' AS integer) AS cr_returning_cdemo_sk,
        CAST(s.payload->>'cr_returning_hdemo_sk' AS integer) AS cr_returning_hdemo_sk,
        CAST(s.payload->>'cr_returning_addr_sk' AS integer) AS cr_returning_addr_sk,
        CAST(s.payload->>'cr_call_center_sk' AS integer) AS cr_call_center_sk,
        CAST(s.payload->>'cr_catalog_page_sk' AS integer) AS cr_catalog_page_sk,
        CAST(s.payload->>'cr_ship_mode_sk' AS integer) AS cr_ship_mode_sk,
        CAST(s.payload->>'cr_warehouse_sk' AS integer) AS cr_warehouse_sk,
        CAST(s.payload->>'cr_reason_sk' AS integer) AS cr_reason_sk,
        CAST(s.payload->>'cr_order_number' AS integer) AS cr_order_number,
        CAST(s.payload->>'cr_return_quantity' AS integer) AS cr_return_quantity,
        CAST(s.payload->>'cr_return_amount' AS numeric) AS cr_return_amount,
        CAST(s.payload->>'cr_return_tax' AS numeric) AS cr_return_tax,
        CAST(s.payload->>'cr_return_amt_inc_tax' AS numeric) AS cr_return_amt_inc_tax,
        CAST(s.payload->>'cr_fee' AS numeric) AS cr_fee,
        CAST(s.payload->>'cr_return_ship_cost' AS numeric) AS cr_return_ship_cost,
        CAST(s.payload->>'cr_refunded_cash' AS numeric) AS cr_refunded_cash,
        CAST(s.payload->>'cr_reversed_charge' AS numeric) AS cr_reversed_charge,
        CAST(s.payload->>'cr_store_credit' AS numeric) AS cr_store_credit,
        CAST(s.payload->>'cr_net_loss' AS numeric) AS cr_net_loss
    FROM tpcds_dv.link_catalog_returns l
    JOIN tpcds_dv.sat_catalog_returns s ON l.hk_link_catalog_returns = s.hk_link_catalog_returns
),
web_returns AS (
    SELECT 
        CAST(s.payload->>'wr_returned_date_sk' AS integer) AS wr_returned_date_sk,
        CAST(s.payload->>'wr_returned_time_sk' AS integer) AS wr_returned_time_sk,
        CAST(s.payload->>'wr_item_sk' AS integer) AS wr_item_sk,
        CAST(s.payload->>'wr_refunded_customer_sk' AS integer) AS wr_refunded_customer_sk,
        CAST(s.payload->>'wr_refunded_cdemo_sk' AS integer) AS wr_refunded_cdemo_sk,
        CAST(s.payload->>'wr_refunded_hdemo_sk' AS integer) AS wr_refunded_hdemo_sk,
        CAST(s.payload->>'wr_refunded_addr_sk' AS integer) AS wr_refunded_addr_sk,
        CAST(s.payload->>'wr_returning_customer_sk' AS integer) AS wr_returning_customer_sk,
        CAST(s.payload->>'wr_returning_cdemo_sk' AS integer) AS wr_returning_cdemo_sk,
        CAST(s.payload->>'wr_returning_hdemo_sk' AS integer) AS wr_returning_hdemo_sk,
        CAST(s.payload->>'wr_returning_addr_sk' AS integer) AS wr_returning_addr_sk,
        CAST(s.payload->>'wr_web_page_sk' AS integer) AS wr_web_page_sk,
        CAST(s.payload->>'wr_reason_sk' AS integer) AS wr_reason_sk,
        CAST(s.payload->>'wr_order_number' AS integer) AS wr_order_number,
        CAST(s.payload->>'wr_return_quantity' AS integer) AS wr_return_quantity,
        CAST(s.payload->>'wr_return_amt' AS numeric) AS wr_return_amt,
        CAST(s.payload->>'wr_return_tax' AS numeric) AS wr_return_tax,
        CAST(s.payload->>'wr_return_amt_inc_tax' AS numeric) AS wr_return_amt_inc_tax,
        CAST(s.payload->>'wr_fee' AS numeric) AS wr_fee,
        CAST(s.payload->>'wr_return_ship_cost' AS numeric) AS wr_return_ship_cost,
        CAST(s.payload->>'wr_refunded_cash' AS numeric) AS wr_refunded_cash,
        CAST(s.payload->>'wr_reversed_charge' AS numeric) AS wr_reversed_charge,
        CAST(s.payload->>'wr_account_credit' AS numeric) AS wr_account_credit,
        CAST(s.payload->>'wr_net_loss' AS numeric) AS wr_net_loss
    FROM tpcds_dv.link_web_returns l
    JOIN tpcds_dv.sat_web_returns s ON l.hk_link_web_returns = s.hk_link_web_returns
),
web_sales AS (
    SELECT 
        CAST(s.payload->>'ws_sold_date_sk' AS integer) AS ws_sold_date_sk,
        CAST(s.payload->>'ws_sold_time_sk' AS integer) AS ws_sold_time_sk,
        CAST(s.payload->>'ws_ship_date_sk' AS integer) AS ws_ship_date_sk,
        CAST(s.payload->>'ws_item_sk' AS integer) AS ws_item_sk,
        CAST(s.payload->>'ws_bill_customer_sk' AS integer) AS ws_bill_customer_sk,
        CAST(s.payload->>'ws_bill_cdemo_sk' AS integer) AS ws_bill_cdemo_sk,
        CAST(s.payload->>'ws_bill_hdemo_sk' AS integer) AS ws_bill_hdemo_sk,
        CAST(s.payload->>'ws_bill_addr_sk' AS integer) AS ws_bill_addr_sk,
        CAST(s.payload->>'ws_ship_customer_sk' AS integer) AS ws_ship_customer_sk,
        CAST(s.payload->>'ws_ship_cdemo_sk' AS integer) AS ws_ship_cdemo_sk,
        CAST(s.payload->>'ws_ship_hdemo_sk' AS integer) AS ws_ship_hdemo_sk,
        CAST(s.payload->>'ws_ship_addr_sk' AS integer) AS ws_ship_addr_sk,
        CAST(s.payload->>'ws_web_page_sk' AS integer) AS ws_web_page_sk,
        CAST(s.payload->>'ws_web_site_sk' AS integer) AS ws_web_site_sk,
        CAST(s.payload->>'ws_ship_mode_sk' AS integer) AS ws_ship_mode_sk,
        CAST(s.payload->>'ws_warehouse_sk' AS integer) AS ws_warehouse_sk,
        CAST(s.payload->>'ws_promo_sk' AS integer) AS ws_promo_sk,
        CAST(s.payload->>'ws_order_number' AS integer) AS ws_order_number,
        CAST(s.payload->>'ws_quantity' AS integer) AS ws_quantity,
        CAST(s.payload->>'ws_wholesale_cost' AS numeric) AS ws_wholesale_cost,
        CAST(s.payload->>'ws_list_price' AS numeric) AS ws_list_price,
        CAST(s.payload->>'ws_sales_price' AS numeric) AS ws_sales_price,
        CAST(s.payload->>'ws_ext_discount_amt' AS numeric) AS ws_ext_discount_amt,
        CAST(s.payload->>'ws_ext_sales_price' AS numeric) AS ws_ext_sales_price,
        CAST(s.payload->>'ws_ext_wholesale_cost' AS numeric) AS ws_ext_wholesale_cost,
        CAST(s.payload->>'ws_ext_list_price' AS numeric) AS ws_ext_list_price,
        CAST(s.payload->>'ws_ext_tax' AS numeric) AS ws_ext_tax,
        CAST(s.payload->>'ws_coupon_amt' AS numeric) AS ws_coupon_amt,
        CAST(s.payload->>'ws_ext_ship_cost' AS numeric) AS ws_ext_ship_cost,
        CAST(s.payload->>'ws_net_paid' AS numeric) AS ws_net_paid,
        CAST(s.payload->>'ws_net_paid_inc_tax' AS numeric) AS ws_net_paid_inc_tax,
        CAST(s.payload->>'ws_net_paid_inc_ship' AS numeric) AS ws_net_paid_inc_ship,
        CAST(s.payload->>'ws_net_paid_inc_ship_tax' AS numeric) AS ws_net_paid_inc_ship_tax,
        CAST(s.payload->>'ws_net_profit' AS numeric) AS ws_net_profit
    FROM tpcds_dv.link_web_sales l
    JOIN tpcds_dv.sat_web_sales s ON l.hk_link_web_sales = s.hk_link_web_sales
),
catalog_sales AS (
    SELECT 
        CAST(s.payload->>'cs_sold_date_sk' AS integer) AS cs_sold_date_sk,
        CAST(s.payload->>'cs_sold_time_sk' AS integer) AS cs_sold_time_sk,
        CAST(s.payload->>'cs_ship_date_sk' AS integer) AS cs_ship_date_sk,
        CAST(s.payload->>'cs_bill_customer_sk' AS integer) AS cs_bill_customer_sk,
        CAST(s.payload->>'cs_bill_cdemo_sk' AS integer) AS cs_bill_cdemo_sk,
        CAST(s.payload->>'cs_bill_hdemo_sk' AS integer) AS cs_bill_hdemo_sk,
        CAST(s.payload->>'cs_bill_addr_sk' AS integer) AS cs_bill_addr_sk,
        CAST(s.payload->>'cs_ship_customer_sk' AS integer) AS cs_ship_customer_sk,
        CAST(s.payload->>'cs_ship_cdemo_sk' AS integer) AS cs_ship_cdemo_sk,
        CAST(s.payload->>'cs_ship_hdemo_sk' AS integer) AS cs_ship_hdemo_sk,
        CAST(s.payload->>'cs_ship_addr_sk' AS integer) AS cs_ship_addr_sk,
        CAST(s.payload->>'cs_call_center_sk' AS integer) AS cs_call_center_sk,
        CAST(s.payload->>'cs_catalog_page_sk' AS integer) AS cs_catalog_page_sk,
        CAST(s.payload->>'cs_ship_mode_sk' AS integer) AS cs_ship_mode_sk,
        CAST(s.payload->>'cs_warehouse_sk' AS integer) AS cs_warehouse_sk,
        CAST(s.payload->>'cs_item_sk' AS integer) AS cs_item_sk,
        CAST(s.payload->>'cs_promo_sk' AS integer) AS cs_promo_sk,
        CAST(s.payload->>'cs_order_number' AS integer) AS cs_order_number,
        CAST(s.payload->>'cs_quantity' AS integer) AS cs_quantity,
        CAST(s.payload->>'cs_wholesale_cost' AS numeric) AS cs_wholesale_cost,
        CAST(s.payload->>'cs_list_price' AS numeric) AS cs_list_price,
        CAST(s.payload->>'cs_sales_price' AS numeric) AS cs_sales_price,
        CAST(s.payload->>'cs_ext_discount_amt' AS numeric) AS cs_ext_discount_amt,
        CAST(s.payload->>'cs_ext_sales_price' AS numeric) AS cs_ext_sales_price,
        CAST(s.payload->>'cs_ext_wholesale_cost' AS numeric) AS cs_ext_wholesale_cost,
        CAST(s.payload->>'cs_ext_list_price' AS numeric) AS cs_ext_list_price,
        CAST(s.payload->>'cs_ext_tax' AS numeric) AS cs_ext_tax,
        CAST(s.payload->>'cs_coupon_amt' AS numeric) AS cs_coupon_amt,
        CAST(s.payload->>'cs_ext_ship_cost' AS numeric) AS cs_ext_ship_cost,
        CAST(s.payload->>'cs_net_paid' AS numeric) AS cs_net_paid,
        CAST(s.payload->>'cs_net_paid_inc_tax' AS numeric) AS cs_net_paid_inc_tax,
        CAST(s.payload->>'cs_net_paid_inc_ship' AS numeric) AS cs_net_paid_inc_ship,
        CAST(s.payload->>'cs_net_paid_inc_ship_tax' AS numeric) AS cs_net_paid_inc_ship_tax,
        CAST(s.payload->>'cs_net_profit' AS numeric) AS cs_net_profit
    FROM tpcds_dv.link_catalog_sales l
    JOIN tpcds_dv.sat_catalog_sales s ON l.hk_link_catalog_sales = s.hk_link_catalog_sales
),
store_sales AS (
    SELECT 
        CAST(s.payload->>'ss_sold_date_sk' AS integer) AS ss_sold_date_sk,
        CAST(s.payload->>'ss_sold_time_sk' AS integer) AS ss_sold_time_sk,
        CAST(s.payload->>'ss_item_sk' AS integer) AS ss_item_sk,
        CAST(s.payload->>'ss_customer_sk' AS integer) AS ss_customer_sk,
        CAST(s.payload->>'ss_cdemo_sk' AS integer) AS ss_cdemo_sk,
        CAST(s.payload->>'ss_hdemo_sk' AS integer) AS ss_hdemo_sk,
        CAST(s.payload->>'ss_addr_sk' AS integer) AS ss_addr_sk,
        CAST(s.payload->>'ss_store_sk' AS integer) AS ss_store_sk,
        CAST(s.payload->>'ss_promo_sk' AS integer) AS ss_promo_sk,
        CAST(s.payload->>'ss_ticket_number' AS integer) AS ss_ticket_number,
        CAST(s.payload->>'ss_quantity' AS integer) AS ss_quantity,
        CAST(s.payload->>'ss_wholesale_cost' AS numeric) AS ss_wholesale_cost,
        CAST(s.payload->>'ss_list_price' AS numeric) AS ss_list_price,
        CAST(s.payload->>'ss_sales_price' AS numeric) AS ss_sales_price,
        CAST(s.payload->>'ss_ext_discount_amt' AS numeric) AS ss_ext_discount_amt,
        CAST(s.payload->>'ss_ext_sales_price' AS numeric) AS ss_ext_sales_price,
        CAST(s.payload->>'ss_ext_wholesale_cost' AS numeric) AS ss_ext_wholesale_cost,
        CAST(s.payload->>'ss_ext_list_price' AS numeric) AS ss_ext_list_price,
        CAST(s.payload->>'ss_ext_tax' AS numeric) AS ss_ext_tax,
        CAST(s.payload->>'ss_coupon_amt' AS numeric) AS ss_coupon_amt,
        CAST(s.payload->>'ss_net_paid' AS numeric) AS ss_net_paid,
        CAST(s.payload->>'ss_net_paid_inc_tax' AS numeric) AS ss_net_paid_inc_tax,
        CAST(s.payload->>'ss_net_profit' AS numeric) AS ss_net_profit
    FROM tpcds_dv.link_store_sales l
    JOIN tpcds_dv.sat_store_sales s ON l.hk_link_store_sales = s.hk_link_store_sales
)
select  
   substr(w_warehouse_name,1,20)
  ,sm_type
  ,cc_name
  ,sum(case when (cs_ship_date_sk - cs_sold_date_sk <= 30 ) then 1 else 0 end)  as "30 days" 
  ,sum(case when (cs_ship_date_sk - cs_sold_date_sk > 30) and 
                 (cs_ship_date_sk - cs_sold_date_sk <= 60) then 1 else 0 end )  as "31-60 days" 
  ,sum(case when (cs_ship_date_sk - cs_sold_date_sk > 60) and 
                 (cs_ship_date_sk - cs_sold_date_sk <= 90) then 1 else 0 end)  as "61-90 days" 
  ,sum(case when (cs_ship_date_sk - cs_sold_date_sk > 90) and
                 (cs_ship_date_sk - cs_sold_date_sk <= 120) then 1 else 0 end)  as "91-120 days" 
  ,sum(case when (cs_ship_date_sk - cs_sold_date_sk  > 120) then 1 else 0 end)  as ">120 days" 
from
   catalog_sales
  ,warehouse
  ,ship_mode
  ,call_center
  ,date_dim
where
    d_month_seq between 1212 and 1212 + 11
and cs_ship_date_sk   = d_date_sk
and cs_warehouse_sk   = w_warehouse_sk
and cs_ship_mode_sk   = sm_ship_mode_sk
and cs_call_center_sk = cc_call_center_sk
group by
   substr(w_warehouse_name,1,20)
  ,sm_type
  ,cc_name
order by substr(w_warehouse_name,1,20)
        ,sm_type
        ,cc_name
LIMIT 100;
