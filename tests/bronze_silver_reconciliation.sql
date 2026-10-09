SELECT
    b.source_system,
    b.table_name,
    b.bronze_rows,
    s.silver_rows,
    b.bronze_rows - s.silver_rows AS rows_removed,
    CAST(
        100.0 * (b.bronze_rows - s.silver_rows) / NULLIF(b.bronze_rows, 0)
        AS DECIMAL(5,2)
    ) AS pct_removed,
    CASE
        WHEN b.bronze_rows = s.silver_rows THEN 'No rows removed'
        WHEN s.silver_rows < b.bronze_rows THEN 'Rows filtered/deduplicated'
        ELSE 'CHECK: silver has MORE rows'
    END AS status
FROM (
    SELECT 'CRM' AS source_system, 'cust_info'    AS table_name, COUNT(*) AS bronze_rows FROM bronze.crm_cust_info
    UNION ALL
    SELECT 'CRM', 'prd_info',      COUNT(*) FROM bronze.crm_prd_info
    UNION ALL
    SELECT 'CRM', 'sales_details', COUNT(*) FROM bronze.crm_sales_details
    UNION ALL
    SELECT 'ERP', 'cust_az12',     COUNT(*) FROM bronze.erp_cust_az12
    UNION ALL
    SELECT 'ERP', 'loc_a101',      COUNT(*) FROM bronze.erp_loc_a101
    UNION ALL
    SELECT 'ERP', 'px_cat_g1v2',   COUNT(*) FROM bronze.erp_px_cat_g1v2
) b
JOIN (
    SELECT 'CRM' AS source_system, 'cust_info'    AS table_name, COUNT(*) AS silver_rows FROM silver.crm_cust_info
    UNION ALL
    SELECT 'CRM', 'prd_info',      COUNT(*) FROM silver.crm_prd_info
    UNION ALL
    SELECT 'CRM', 'sales_details', COUNT(*) FROM silver.crm_sales_details
    UNION ALL
    SELECT 'ERP', 'cust_az12',     COUNT(*) FROM silver.erp_cust_az12
    UNION ALL
    SELECT 'ERP', 'loc_a101',      COUNT(*) FROM silver.erp_loc_a101
    UNION ALL
    SELECT 'ERP', 'px_cat_g1v2',   COUNT(*) FROM silver.erp_px_cat_g1v2
) s
  ON b.source_system = s.source_system
 AND b.table_name    = s.table_name
ORDER BY b.source_system, b.table_name;


