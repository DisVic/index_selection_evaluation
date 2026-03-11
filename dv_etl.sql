INSERT INTO tpcds_dv.hub_customer (hk_hub_customer, bk_customer)
SELECT DISTINCT digest(c_customer_id, 'sha256'), c_customer_id FROM public.customer WHERE c_customer_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_item (hk_hub_item, bk_item)
SELECT DISTINCT digest(i_item_id, 'sha256'), i_item_id FROM public.item WHERE i_item_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_store (hk_hub_store, bk_store)
SELECT DISTINCT digest(s_store_id, 'sha256'), s_store_id FROM public.store WHERE s_store_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_web_site (hk_hub_web_site, bk_web_site)
SELECT DISTINCT digest(web_site_id, 'sha256'), web_site_id FROM public.web_site WHERE web_site_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_call_center (hk_hub_call_center, bk_call_center)
SELECT DISTINCT digest(cc_call_center_id, 'sha256'), cc_call_center_id FROM public.call_center WHERE cc_call_center_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_promotion (hk_hub_promotion, bk_promotion)
SELECT DISTINCT digest(p_promo_id, 'sha256'), p_promo_id FROM public.promotion WHERE p_promo_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_warehouse (hk_hub_warehouse, bk_warehouse)
SELECT DISTINCT digest(w_warehouse_id, 'sha256'), w_warehouse_id FROM public.warehouse WHERE w_warehouse_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_catalog_page (hk_hub_catalog_page, bk_catalog_page)
SELECT DISTINCT digest(cp_catalog_page_id, 'sha256'), cp_catalog_page_id FROM public.catalog_page WHERE cp_catalog_page_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_customer_address (hk_hub_customer_address, bk_customer_address)
SELECT DISTINCT digest(ca_address_id, 'sha256'), ca_address_id FROM public.customer_address WHERE ca_address_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_customer_demographics (hk_hub_customer_demographics, bk_customer_demographics)
SELECT DISTINCT digest(cd_demo_sk::text, 'sha256'), cd_demo_sk::text FROM public.customer_demographics WHERE cd_demo_sk::text IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_household_demographics (hk_hub_household_demographics, bk_household_demographics)
SELECT DISTINCT digest(hd_demo_sk::text, 'sha256'), hd_demo_sk::text FROM public.household_demographics WHERE hd_demo_sk::text IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_date_dim (hk_hub_date_dim, bk_date_dim)
SELECT DISTINCT digest(d_date_id, 'sha256'), d_date_id FROM public.date_dim WHERE d_date_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_time_dim (hk_hub_time_dim, bk_time_dim)
SELECT DISTINCT digest(t_time_id, 'sha256'), t_time_id FROM public.time_dim WHERE t_time_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_income_band (hk_hub_income_band, bk_income_band)
SELECT DISTINCT digest(ib_income_band_sk::text, 'sha256'), ib_income_band_sk::text FROM public.income_band WHERE ib_income_band_sk::text IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_reason (hk_hub_reason, bk_reason)
SELECT DISTINCT digest(r_reason_id, 'sha256'), r_reason_id FROM public.reason WHERE r_reason_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_ship_mode (hk_hub_ship_mode, bk_ship_mode)
SELECT DISTINCT digest(sm_ship_mode_id, 'sha256'), sm_ship_mode_id FROM public.ship_mode WHERE sm_ship_mode_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.hub_web_page (hk_hub_web_page, bk_web_page)
SELECT DISTINCT digest(wp_web_page_id, 'sha256'), wp_web_page_id FROM public.web_page WHERE wp_web_page_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.link_store_sales (hk_link_store_sales, hk_hub_item_ss_item_sk, hk_hub_customer_ss_customer_sk, hk_hub_store_ss_store_sk, hk_hub_promotion_ss_promo_sk, hk_hub_customer_demographics_ss_cdemo_sk, hk_hub_household_demographics_ss_hdemo_sk, hk_hub_customer_address_ss_addr_sk, hk_hub_date_dim_ss_sold_date_sk, hk_hub_time_dim_ss_sold_time_sk)
SELECT digest(COALESCE(public.store_sales.ss_item_sk::varchar, '') || '|' || COALESCE(public.store_sales.ss_ticket_number::varchar, ''), 'sha256'), digest(item_ss_item_sk.i_item_id, 'sha256'), digest(customer_ss_customer_sk.c_customer_id, 'sha256'), digest(store_ss_store_sk.s_store_id, 'sha256'), digest(promotion_ss_promo_sk.p_promo_id, 'sha256'), digest(customer_demographics_ss_cdemo_sk.cd_demo_sk::text, 'sha256'), digest(household_demographics_ss_hdemo_sk.hd_demo_sk::text, 'sha256'), digest(customer_address_ss_addr_sk.ca_address_id, 'sha256'), digest(date_dim_ss_sold_date_sk.d_date_id, 'sha256'), digest(time_dim_ss_sold_time_sk.t_time_id, 'sha256')
FROM public.store_sales
LEFT JOIN public.item AS item_ss_item_sk ON public.store_sales.ss_item_sk = item_ss_item_sk.i_item_sk
LEFT JOIN public.customer AS customer_ss_customer_sk ON public.store_sales.ss_customer_sk = customer_ss_customer_sk.c_customer_sk
LEFT JOIN public.store AS store_ss_store_sk ON public.store_sales.ss_store_sk = store_ss_store_sk.s_store_sk
LEFT JOIN public.promotion AS promotion_ss_promo_sk ON public.store_sales.ss_promo_sk = promotion_ss_promo_sk.p_promo_sk
LEFT JOIN public.customer_demographics AS customer_demographics_ss_cdemo_sk ON public.store_sales.ss_cdemo_sk = customer_demographics_ss_cdemo_sk.cd_demo_sk
LEFT JOIN public.household_demographics AS household_demographics_ss_hdemo_sk ON public.store_sales.ss_hdemo_sk = household_demographics_ss_hdemo_sk.hd_demo_sk
LEFT JOIN public.customer_address AS customer_address_ss_addr_sk ON public.store_sales.ss_addr_sk = customer_address_ss_addr_sk.ca_address_sk
LEFT JOIN public.date_dim AS date_dim_ss_sold_date_sk ON public.store_sales.ss_sold_date_sk = date_dim_ss_sold_date_sk.d_date_sk
LEFT JOIN public.time_dim AS time_dim_ss_sold_time_sk ON public.store_sales.ss_sold_time_sk = time_dim_ss_sold_time_sk.t_time_sk ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.link_store_returns (hk_link_store_returns, hk_hub_item_sr_item_sk, hk_hub_customer_sr_customer_sk, hk_hub_store_sr_store_sk, hk_hub_reason_sr_reason_sk, hk_hub_customer_demographics_sr_cdemo_sk, hk_hub_household_demographics_sr_hdemo_sk, hk_hub_customer_address_sr_addr_sk, hk_hub_date_dim_sr_returned_date_sk, hk_hub_time_dim_sr_return_time_sk)
SELECT digest(COALESCE(public.store_returns.sr_item_sk::varchar, '') || '|' || COALESCE(public.store_returns.sr_ticket_number::varchar, ''), 'sha256'), digest(item_sr_item_sk.i_item_id, 'sha256'), digest(customer_sr_customer_sk.c_customer_id, 'sha256'), digest(store_sr_store_sk.s_store_id, 'sha256'), digest(reason_sr_reason_sk.r_reason_id, 'sha256'), digest(customer_demographics_sr_cdemo_sk.cd_demo_sk::text, 'sha256'), digest(household_demographics_sr_hdemo_sk.hd_demo_sk::text, 'sha256'), digest(customer_address_sr_addr_sk.ca_address_id, 'sha256'), digest(date_dim_sr_returned_date_sk.d_date_id, 'sha256'), digest(time_dim_sr_return_time_sk.t_time_id, 'sha256')
FROM public.store_returns
LEFT JOIN public.item AS item_sr_item_sk ON public.store_returns.sr_item_sk = item_sr_item_sk.i_item_sk
LEFT JOIN public.customer AS customer_sr_customer_sk ON public.store_returns.sr_customer_sk = customer_sr_customer_sk.c_customer_sk
LEFT JOIN public.store AS store_sr_store_sk ON public.store_returns.sr_store_sk = store_sr_store_sk.s_store_sk
LEFT JOIN public.reason AS reason_sr_reason_sk ON public.store_returns.sr_reason_sk = reason_sr_reason_sk.r_reason_sk
LEFT JOIN public.customer_demographics AS customer_demographics_sr_cdemo_sk ON public.store_returns.sr_cdemo_sk = customer_demographics_sr_cdemo_sk.cd_demo_sk
LEFT JOIN public.household_demographics AS household_demographics_sr_hdemo_sk ON public.store_returns.sr_hdemo_sk = household_demographics_sr_hdemo_sk.hd_demo_sk
LEFT JOIN public.customer_address AS customer_address_sr_addr_sk ON public.store_returns.sr_addr_sk = customer_address_sr_addr_sk.ca_address_sk
LEFT JOIN public.date_dim AS date_dim_sr_returned_date_sk ON public.store_returns.sr_returned_date_sk = date_dim_sr_returned_date_sk.d_date_sk
LEFT JOIN public.time_dim AS time_dim_sr_return_time_sk ON public.store_returns.sr_return_time_sk = time_dim_sr_return_time_sk.t_time_sk ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.link_catalog_sales (hk_link_catalog_sales, hk_hub_item_cs_item_sk, hk_hub_customer_cs_bill_customer_sk, hk_hub_customer_cs_ship_customer_sk, hk_hub_call_center_cs_call_center_sk, hk_hub_catalog_page_cs_catalog_page_sk, hk_hub_ship_mode_cs_ship_mode_sk, hk_hub_warehouse_cs_warehouse_sk, hk_hub_promotion_cs_promo_sk, hk_hub_date_dim_cs_sold_date_sk, hk_hub_time_dim_cs_sold_time_sk, hk_hub_customer_demographics_cs_bill_cdemo_sk, hk_hub_household_demographics_cs_bill_hdemo_sk, hk_hub_customer_address_cs_bill_addr_sk, hk_hub_customer_demographics_cs_ship_cdemo_sk, hk_hub_household_demographics_cs_ship_hdemo_sk, hk_hub_customer_address_cs_ship_addr_sk)
SELECT digest(COALESCE(public.catalog_sales.cs_item_sk::varchar, '') || '|' || COALESCE(public.catalog_sales.cs_order_number::varchar, ''), 'sha256'), digest(item_cs_item_sk.i_item_id, 'sha256'), digest(customer_cs_bill_customer_sk.c_customer_id, 'sha256'), digest(customer_cs_ship_customer_sk.c_customer_id, 'sha256'), digest(call_center_cs_call_center_sk.cc_call_center_id, 'sha256'), digest(catalog_page_cs_catalog_page_sk.cp_catalog_page_id, 'sha256'), digest(ship_mode_cs_ship_mode_sk.sm_ship_mode_id, 'sha256'), digest(warehouse_cs_warehouse_sk.w_warehouse_id, 'sha256'), digest(promotion_cs_promo_sk.p_promo_id, 'sha256'), digest(date_dim_cs_sold_date_sk.d_date_id, 'sha256'), digest(time_dim_cs_sold_time_sk.t_time_id, 'sha256'), digest(customer_demographics_cs_bill_cdemo_sk.cd_demo_sk::text, 'sha256'), digest(household_demographics_cs_bill_hdemo_sk.hd_demo_sk::text, 'sha256'), digest(customer_address_cs_bill_addr_sk.ca_address_id, 'sha256'), digest(customer_demographics_cs_ship_cdemo_sk.cd_demo_sk::text, 'sha256'), digest(household_demographics_cs_ship_hdemo_sk.hd_demo_sk::text, 'sha256'), digest(customer_address_cs_ship_addr_sk.ca_address_id, 'sha256')
FROM public.catalog_sales
LEFT JOIN public.item AS item_cs_item_sk ON public.catalog_sales.cs_item_sk = item_cs_item_sk.i_item_sk
LEFT JOIN public.customer AS customer_cs_bill_customer_sk ON public.catalog_sales.cs_bill_customer_sk = customer_cs_bill_customer_sk.c_customer_sk
LEFT JOIN public.customer AS customer_cs_ship_customer_sk ON public.catalog_sales.cs_ship_customer_sk = customer_cs_ship_customer_sk.c_customer_sk
LEFT JOIN public.call_center AS call_center_cs_call_center_sk ON public.catalog_sales.cs_call_center_sk = call_center_cs_call_center_sk.cc_call_center_sk
LEFT JOIN public.catalog_page AS catalog_page_cs_catalog_page_sk ON public.catalog_sales.cs_catalog_page_sk = catalog_page_cs_catalog_page_sk.cp_catalog_page_sk
LEFT JOIN public.ship_mode AS ship_mode_cs_ship_mode_sk ON public.catalog_sales.cs_ship_mode_sk = ship_mode_cs_ship_mode_sk.sm_ship_mode_sk
LEFT JOIN public.warehouse AS warehouse_cs_warehouse_sk ON public.catalog_sales.cs_warehouse_sk = warehouse_cs_warehouse_sk.w_warehouse_sk
LEFT JOIN public.promotion AS promotion_cs_promo_sk ON public.catalog_sales.cs_promo_sk = promotion_cs_promo_sk.p_promo_sk
LEFT JOIN public.date_dim AS date_dim_cs_sold_date_sk ON public.catalog_sales.cs_sold_date_sk = date_dim_cs_sold_date_sk.d_date_sk
LEFT JOIN public.time_dim AS time_dim_cs_sold_time_sk ON public.catalog_sales.cs_sold_time_sk = time_dim_cs_sold_time_sk.t_time_sk
LEFT JOIN public.customer_demographics AS customer_demographics_cs_bill_cdemo_sk ON public.catalog_sales.cs_bill_cdemo_sk = customer_demographics_cs_bill_cdemo_sk.cd_demo_sk
LEFT JOIN public.household_demographics AS household_demographics_cs_bill_hdemo_sk ON public.catalog_sales.cs_bill_hdemo_sk = household_demographics_cs_bill_hdemo_sk.hd_demo_sk
LEFT JOIN public.customer_address AS customer_address_cs_bill_addr_sk ON public.catalog_sales.cs_bill_addr_sk = customer_address_cs_bill_addr_sk.ca_address_sk
LEFT JOIN public.customer_demographics AS customer_demographics_cs_ship_cdemo_sk ON public.catalog_sales.cs_ship_cdemo_sk = customer_demographics_cs_ship_cdemo_sk.cd_demo_sk
LEFT JOIN public.household_demographics AS household_demographics_cs_ship_hdemo_sk ON public.catalog_sales.cs_ship_hdemo_sk = household_demographics_cs_ship_hdemo_sk.hd_demo_sk
LEFT JOIN public.customer_address AS customer_address_cs_ship_addr_sk ON public.catalog_sales.cs_ship_addr_sk = customer_address_cs_ship_addr_sk.ca_address_sk ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.link_catalog_returns (hk_link_catalog_returns, hk_hub_item_cr_item_sk, hk_hub_customer_cr_refunded_customer_sk, hk_hub_customer_cr_returning_customer_sk, hk_hub_call_center_cr_call_center_sk, hk_hub_catalog_page_cr_catalog_page_sk, hk_hub_ship_mode_cr_ship_mode_sk, hk_hub_warehouse_cr_warehouse_sk, hk_hub_reason_cr_reason_sk, hk_hub_date_dim_cr_returned_date_sk, hk_hub_time_dim_cr_returned_time_sk, hk_hub_customer_demographics_cr_refunded_cdemo_sk, hk_hub_household_demographics_cr_refunded_hdemo_sk, hk_hub_customer_address_cr_refunded_addr_sk, hk_hub_customer_demographics_cr_returning_cdemo_sk, hk_hub_household_demographics_cr_returning_hdemo_sk, hk_hub_customer_address_cr_returning_addr_sk)
SELECT digest(COALESCE(public.catalog_returns.cr_item_sk::varchar, '') || '|' || COALESCE(public.catalog_returns.cr_order_number::varchar, ''), 'sha256'), digest(item_cr_item_sk.i_item_id, 'sha256'), digest(customer_cr_refunded_customer_sk.c_customer_id, 'sha256'), digest(customer_cr_returning_customer_sk.c_customer_id, 'sha256'), digest(call_center_cr_call_center_sk.cc_call_center_id, 'sha256'), digest(catalog_page_cr_catalog_page_sk.cp_catalog_page_id, 'sha256'), digest(ship_mode_cr_ship_mode_sk.sm_ship_mode_id, 'sha256'), digest(warehouse_cr_warehouse_sk.w_warehouse_id, 'sha256'), digest(reason_cr_reason_sk.r_reason_id, 'sha256'), digest(date_dim_cr_returned_date_sk.d_date_id, 'sha256'), digest(time_dim_cr_returned_time_sk.t_time_id, 'sha256'), digest(customer_demographics_cr_refunded_cdemo_sk.cd_demo_sk::text, 'sha256'), digest(household_demographics_cr_refunded_hdemo_sk.hd_demo_sk::text, 'sha256'), digest(customer_address_cr_refunded_addr_sk.ca_address_id, 'sha256'), digest(customer_demographics_cr_returning_cdemo_sk.cd_demo_sk::text, 'sha256'), digest(household_demographics_cr_returning_hdemo_sk.hd_demo_sk::text, 'sha256'), digest(customer_address_cr_returning_addr_sk.ca_address_id, 'sha256')
FROM public.catalog_returns
LEFT JOIN public.item AS item_cr_item_sk ON public.catalog_returns.cr_item_sk = item_cr_item_sk.i_item_sk
LEFT JOIN public.customer AS customer_cr_refunded_customer_sk ON public.catalog_returns.cr_refunded_customer_sk = customer_cr_refunded_customer_sk.c_customer_sk
LEFT JOIN public.customer AS customer_cr_returning_customer_sk ON public.catalog_returns.cr_returning_customer_sk = customer_cr_returning_customer_sk.c_customer_sk
LEFT JOIN public.call_center AS call_center_cr_call_center_sk ON public.catalog_returns.cr_call_center_sk = call_center_cr_call_center_sk.cc_call_center_sk
LEFT JOIN public.catalog_page AS catalog_page_cr_catalog_page_sk ON public.catalog_returns.cr_catalog_page_sk = catalog_page_cr_catalog_page_sk.cp_catalog_page_sk
LEFT JOIN public.ship_mode AS ship_mode_cr_ship_mode_sk ON public.catalog_returns.cr_ship_mode_sk = ship_mode_cr_ship_mode_sk.sm_ship_mode_sk
LEFT JOIN public.warehouse AS warehouse_cr_warehouse_sk ON public.catalog_returns.cr_warehouse_sk = warehouse_cr_warehouse_sk.w_warehouse_sk
LEFT JOIN public.reason AS reason_cr_reason_sk ON public.catalog_returns.cr_reason_sk = reason_cr_reason_sk.r_reason_sk
LEFT JOIN public.date_dim AS date_dim_cr_returned_date_sk ON public.catalog_returns.cr_returned_date_sk = date_dim_cr_returned_date_sk.d_date_sk
LEFT JOIN public.time_dim AS time_dim_cr_returned_time_sk ON public.catalog_returns.cr_returned_time_sk = time_dim_cr_returned_time_sk.t_time_sk
LEFT JOIN public.customer_demographics AS customer_demographics_cr_refunded_cdemo_sk ON public.catalog_returns.cr_refunded_cdemo_sk = customer_demographics_cr_refunded_cdemo_sk.cd_demo_sk
LEFT JOIN public.household_demographics AS household_demographics_cr_refunded_hdemo_sk ON public.catalog_returns.cr_refunded_hdemo_sk = household_demographics_cr_refunded_hdemo_sk.hd_demo_sk
LEFT JOIN public.customer_address AS customer_address_cr_refunded_addr_sk ON public.catalog_returns.cr_refunded_addr_sk = customer_address_cr_refunded_addr_sk.ca_address_sk
LEFT JOIN public.customer_demographics AS customer_demographics_cr_returning_cdemo_sk ON public.catalog_returns.cr_returning_cdemo_sk = customer_demographics_cr_returning_cdemo_sk.cd_demo_sk
LEFT JOIN public.household_demographics AS household_demographics_cr_returning_hdemo_sk ON public.catalog_returns.cr_returning_hdemo_sk = household_demographics_cr_returning_hdemo_sk.hd_demo_sk
LEFT JOIN public.customer_address AS customer_address_cr_returning_addr_sk ON public.catalog_returns.cr_returning_addr_sk = customer_address_cr_returning_addr_sk.ca_address_sk ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.link_web_sales (hk_link_web_sales, hk_hub_item_ws_item_sk, hk_hub_customer_ws_bill_customer_sk, hk_hub_customer_ws_ship_customer_sk, hk_hub_web_page_ws_web_page_sk, hk_hub_web_site_ws_web_site_sk, hk_hub_ship_mode_ws_ship_mode_sk, hk_hub_warehouse_ws_warehouse_sk, hk_hub_promotion_ws_promo_sk, hk_hub_date_dim_ws_sold_date_sk, hk_hub_time_dim_ws_sold_time_sk, hk_hub_customer_demographics_ws_bill_cdemo_sk, hk_hub_household_demographics_ws_bill_hdemo_sk, hk_hub_customer_address_ws_bill_addr_sk, hk_hub_customer_demographics_ws_ship_cdemo_sk, hk_hub_household_demographics_ws_ship_hdemo_sk, hk_hub_customer_address_ws_ship_addr_sk)
SELECT digest(COALESCE(public.web_sales.ws_item_sk::varchar, '') || '|' || COALESCE(public.web_sales.ws_order_number::varchar, ''), 'sha256'), digest(item_ws_item_sk.i_item_id, 'sha256'), digest(customer_ws_bill_customer_sk.c_customer_id, 'sha256'), digest(customer_ws_ship_customer_sk.c_customer_id, 'sha256'), digest(web_page_ws_web_page_sk.wp_web_page_id, 'sha256'), digest(web_site_ws_web_site_sk.web_site_id, 'sha256'), digest(ship_mode_ws_ship_mode_sk.sm_ship_mode_id, 'sha256'), digest(warehouse_ws_warehouse_sk.w_warehouse_id, 'sha256'), digest(promotion_ws_promo_sk.p_promo_id, 'sha256'), digest(date_dim_ws_sold_date_sk.d_date_id, 'sha256'), digest(time_dim_ws_sold_time_sk.t_time_id, 'sha256'), digest(customer_demographics_ws_bill_cdemo_sk.cd_demo_sk::text, 'sha256'), digest(household_demographics_ws_bill_hdemo_sk.hd_demo_sk::text, 'sha256'), digest(customer_address_ws_bill_addr_sk.ca_address_id, 'sha256'), digest(customer_demographics_ws_ship_cdemo_sk.cd_demo_sk::text, 'sha256'), digest(household_demographics_ws_ship_hdemo_sk.hd_demo_sk::text, 'sha256'), digest(customer_address_ws_ship_addr_sk.ca_address_id, 'sha256')
FROM public.web_sales
LEFT JOIN public.item AS item_ws_item_sk ON public.web_sales.ws_item_sk = item_ws_item_sk.i_item_sk
LEFT JOIN public.customer AS customer_ws_bill_customer_sk ON public.web_sales.ws_bill_customer_sk = customer_ws_bill_customer_sk.c_customer_sk
LEFT JOIN public.customer AS customer_ws_ship_customer_sk ON public.web_sales.ws_ship_customer_sk = customer_ws_ship_customer_sk.c_customer_sk
LEFT JOIN public.web_page AS web_page_ws_web_page_sk ON public.web_sales.ws_web_page_sk = web_page_ws_web_page_sk.wp_web_page_sk
LEFT JOIN public.web_site AS web_site_ws_web_site_sk ON public.web_sales.ws_web_site_sk = web_site_ws_web_site_sk.web_site_sk
LEFT JOIN public.ship_mode AS ship_mode_ws_ship_mode_sk ON public.web_sales.ws_ship_mode_sk = ship_mode_ws_ship_mode_sk.sm_ship_mode_sk
LEFT JOIN public.warehouse AS warehouse_ws_warehouse_sk ON public.web_sales.ws_warehouse_sk = warehouse_ws_warehouse_sk.w_warehouse_sk
LEFT JOIN public.promotion AS promotion_ws_promo_sk ON public.web_sales.ws_promo_sk = promotion_ws_promo_sk.p_promo_sk
LEFT JOIN public.date_dim AS date_dim_ws_sold_date_sk ON public.web_sales.ws_sold_date_sk = date_dim_ws_sold_date_sk.d_date_sk
LEFT JOIN public.time_dim AS time_dim_ws_sold_time_sk ON public.web_sales.ws_sold_time_sk = time_dim_ws_sold_time_sk.t_time_sk
LEFT JOIN public.customer_demographics AS customer_demographics_ws_bill_cdemo_sk ON public.web_sales.ws_bill_cdemo_sk = customer_demographics_ws_bill_cdemo_sk.cd_demo_sk
LEFT JOIN public.household_demographics AS household_demographics_ws_bill_hdemo_sk ON public.web_sales.ws_bill_hdemo_sk = household_demographics_ws_bill_hdemo_sk.hd_demo_sk
LEFT JOIN public.customer_address AS customer_address_ws_bill_addr_sk ON public.web_sales.ws_bill_addr_sk = customer_address_ws_bill_addr_sk.ca_address_sk
LEFT JOIN public.customer_demographics AS customer_demographics_ws_ship_cdemo_sk ON public.web_sales.ws_ship_cdemo_sk = customer_demographics_ws_ship_cdemo_sk.cd_demo_sk
LEFT JOIN public.household_demographics AS household_demographics_ws_ship_hdemo_sk ON public.web_sales.ws_ship_hdemo_sk = household_demographics_ws_ship_hdemo_sk.hd_demo_sk
LEFT JOIN public.customer_address AS customer_address_ws_ship_addr_sk ON public.web_sales.ws_ship_addr_sk = customer_address_ws_ship_addr_sk.ca_address_sk ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.link_web_returns (hk_link_web_returns, hk_hub_item_wr_item_sk, hk_hub_customer_wr_refunded_customer_sk, hk_hub_customer_wr_returning_customer_sk, hk_hub_web_page_wr_web_page_sk, hk_hub_reason_wr_reason_sk, hk_hub_date_dim_wr_returned_date_sk, hk_hub_time_dim_wr_returned_time_sk, hk_hub_customer_demographics_wr_refunded_cdemo_sk, hk_hub_household_demographics_wr_refunded_hdemo_sk, hk_hub_customer_address_wr_refunded_addr_sk, hk_hub_customer_demographics_wr_returning_cdemo_sk, hk_hub_household_demographics_wr_returning_hdemo_sk, hk_hub_customer_address_wr_returning_addr_sk)
SELECT digest(COALESCE(public.web_returns.wr_item_sk::varchar, '') || '|' || COALESCE(public.web_returns.wr_order_number::varchar, ''), 'sha256'), digest(item_wr_item_sk.i_item_id, 'sha256'), digest(customer_wr_refunded_customer_sk.c_customer_id, 'sha256'), digest(customer_wr_returning_customer_sk.c_customer_id, 'sha256'), digest(web_page_wr_web_page_sk.wp_web_page_id, 'sha256'), digest(reason_wr_reason_sk.r_reason_id, 'sha256'), digest(date_dim_wr_returned_date_sk.d_date_id, 'sha256'), digest(time_dim_wr_returned_time_sk.t_time_id, 'sha256'), digest(customer_demographics_wr_refunded_cdemo_sk.cd_demo_sk::text, 'sha256'), digest(household_demographics_wr_refunded_hdemo_sk.hd_demo_sk::text, 'sha256'), digest(customer_address_wr_refunded_addr_sk.ca_address_id, 'sha256'), digest(customer_demographics_wr_returning_cdemo_sk.cd_demo_sk::text, 'sha256'), digest(household_demographics_wr_returning_hdemo_sk.hd_demo_sk::text, 'sha256'), digest(customer_address_wr_returning_addr_sk.ca_address_id, 'sha256')
FROM public.web_returns
LEFT JOIN public.item AS item_wr_item_sk ON public.web_returns.wr_item_sk = item_wr_item_sk.i_item_sk
LEFT JOIN public.customer AS customer_wr_refunded_customer_sk ON public.web_returns.wr_refunded_customer_sk = customer_wr_refunded_customer_sk.c_customer_sk
LEFT JOIN public.customer AS customer_wr_returning_customer_sk ON public.web_returns.wr_returning_customer_sk = customer_wr_returning_customer_sk.c_customer_sk
LEFT JOIN public.web_page AS web_page_wr_web_page_sk ON public.web_returns.wr_web_page_sk = web_page_wr_web_page_sk.wp_web_page_sk
LEFT JOIN public.reason AS reason_wr_reason_sk ON public.web_returns.wr_reason_sk = reason_wr_reason_sk.r_reason_sk
LEFT JOIN public.date_dim AS date_dim_wr_returned_date_sk ON public.web_returns.wr_returned_date_sk = date_dim_wr_returned_date_sk.d_date_sk
LEFT JOIN public.time_dim AS time_dim_wr_returned_time_sk ON public.web_returns.wr_returned_time_sk = time_dim_wr_returned_time_sk.t_time_sk
LEFT JOIN public.customer_demographics AS customer_demographics_wr_refunded_cdemo_sk ON public.web_returns.wr_refunded_cdemo_sk = customer_demographics_wr_refunded_cdemo_sk.cd_demo_sk
LEFT JOIN public.household_demographics AS household_demographics_wr_refunded_hdemo_sk ON public.web_returns.wr_refunded_hdemo_sk = household_demographics_wr_refunded_hdemo_sk.hd_demo_sk
LEFT JOIN public.customer_address AS customer_address_wr_refunded_addr_sk ON public.web_returns.wr_refunded_addr_sk = customer_address_wr_refunded_addr_sk.ca_address_sk
LEFT JOIN public.customer_demographics AS customer_demographics_wr_returning_cdemo_sk ON public.web_returns.wr_returning_cdemo_sk = customer_demographics_wr_returning_cdemo_sk.cd_demo_sk
LEFT JOIN public.household_demographics AS household_demographics_wr_returning_hdemo_sk ON public.web_returns.wr_returning_hdemo_sk = household_demographics_wr_returning_hdemo_sk.hd_demo_sk
LEFT JOIN public.customer_address AS customer_address_wr_returning_addr_sk ON public.web_returns.wr_returning_addr_sk = customer_address_wr_returning_addr_sk.ca_address_sk ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.link_inventory (hk_link_inventory, hk_hub_date_dim_inv_date_sk, hk_hub_item_inv_item_sk, hk_hub_warehouse_inv_warehouse_sk)
SELECT digest(COALESCE(public.inventory.inv_date_sk::varchar, '') || '|' || COALESCE(public.inventory.inv_item_sk::varchar, '') || '|' || COALESCE(public.inventory.inv_warehouse_sk::varchar, ''), 'sha256'), digest(date_dim_inv_date_sk.d_date_id, 'sha256'), digest(item_inv_item_sk.i_item_id, 'sha256'), digest(warehouse_inv_warehouse_sk.w_warehouse_id, 'sha256')
FROM public.inventory
LEFT JOIN public.date_dim AS date_dim_inv_date_sk ON public.inventory.inv_date_sk = date_dim_inv_date_sk.d_date_sk
LEFT JOIN public.item AS item_inv_item_sk ON public.inventory.inv_item_sk = item_inv_item_sk.i_item_sk
LEFT JOIN public.warehouse AS warehouse_inv_warehouse_sk ON public.inventory.inv_warehouse_sk = warehouse_inv_warehouse_sk.w_warehouse_sk ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_customer (hk_hub_customer, hash_diff, payload)
SELECT digest(t.c_customer_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.customer t WHERE t.c_customer_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_item (hk_hub_item, hash_diff, payload)
SELECT digest(t.i_item_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.item t WHERE t.i_item_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_store (hk_hub_store, hash_diff, payload)
SELECT digest(t.s_store_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.store t WHERE t.s_store_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_web_site (hk_hub_web_site, hash_diff, payload)
SELECT digest(t.web_site_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.web_site t WHERE t.web_site_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_call_center (hk_hub_call_center, hash_diff, payload)
SELECT digest(t.cc_call_center_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.call_center t WHERE t.cc_call_center_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_promotion (hk_hub_promotion, hash_diff, payload)
SELECT digest(t.p_promo_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.promotion t WHERE t.p_promo_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_warehouse (hk_hub_warehouse, hash_diff, payload)
SELECT digest(t.w_warehouse_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.warehouse t WHERE t.w_warehouse_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_catalog_page (hk_hub_catalog_page, hash_diff, payload)
SELECT digest(t.cp_catalog_page_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.catalog_page t WHERE t.cp_catalog_page_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_customer_address (hk_hub_customer_address, hash_diff, payload)
SELECT digest(t.ca_address_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.customer_address t WHERE t.ca_address_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_customer_demographics (hk_hub_customer_demographics, hash_diff, payload)
SELECT digest(t.cd_demo_sk::text, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.customer_demographics t WHERE t.cd_demo_sk::text IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_household_demographics (hk_hub_household_demographics, hash_diff, payload)
SELECT digest(t.hd_demo_sk::text, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.household_demographics t WHERE t.hd_demo_sk::text IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_date_dim (hk_hub_date_dim, hash_diff, payload)
SELECT digest(t.d_date_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.date_dim t WHERE t.d_date_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_time_dim (hk_hub_time_dim, hash_diff, payload)
SELECT digest(t.t_time_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.time_dim t WHERE t.t_time_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_income_band (hk_hub_income_band, hash_diff, payload)
SELECT digest(t.ib_income_band_sk::text, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.income_band t WHERE t.ib_income_band_sk::text IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_reason (hk_hub_reason, hash_diff, payload)
SELECT digest(t.r_reason_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.reason t WHERE t.r_reason_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_ship_mode (hk_hub_ship_mode, hash_diff, payload)
SELECT digest(t.sm_ship_mode_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.ship_mode t WHERE t.sm_ship_mode_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_web_page (hk_hub_web_page, hash_diff, payload)
SELECT digest(t.wp_web_page_id, 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.web_page t WHERE t.wp_web_page_id IS NOT NULL ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_store_sales (hk_link_store_sales, hash_diff, payload)
SELECT digest(COALESCE(t.ss_item_sk::varchar, '') || '|' || COALESCE(t.ss_ticket_number::varchar, ''), 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.store_sales t ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_store_returns (hk_link_store_returns, hash_diff, payload)
SELECT digest(COALESCE(t.sr_item_sk::varchar, '') || '|' || COALESCE(t.sr_ticket_number::varchar, ''), 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.store_returns t ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_catalog_sales (hk_link_catalog_sales, hash_diff, payload)
SELECT digest(COALESCE(t.cs_item_sk::varchar, '') || '|' || COALESCE(t.cs_order_number::varchar, ''), 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.catalog_sales t ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_catalog_returns (hk_link_catalog_returns, hash_diff, payload)
SELECT digest(COALESCE(t.cr_item_sk::varchar, '') || '|' || COALESCE(t.cr_order_number::varchar, ''), 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.catalog_returns t ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_web_sales (hk_link_web_sales, hash_diff, payload)
SELECT digest(COALESCE(t.ws_item_sk::varchar, '') || '|' || COALESCE(t.ws_order_number::varchar, ''), 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.web_sales t ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_web_returns (hk_link_web_returns, hash_diff, payload)
SELECT digest(COALESCE(t.wr_item_sk::varchar, '') || '|' || COALESCE(t.wr_order_number::varchar, ''), 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.web_returns t ON CONFLICT DO NOTHING;
INSERT INTO tpcds_dv.sat_inventory (hk_link_inventory, hash_diff, payload)
SELECT digest(COALESCE(t.inv_date_sk::varchar, '') || '|' || COALESCE(t.inv_item_sk::varchar, '') || '|' || COALESCE(t.inv_warehouse_sk::varchar, ''), 'sha256'), digest(row_to_json(t)::text, 'sha256'), row_to_json(t)::jsonb FROM public.inventory t ON CONFLICT DO NOTHING;