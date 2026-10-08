/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script runs a series of quality checks to confirm the integrity,
    consistency, and accuracy of the Gold Layer. The checks make sure of the
    following:
    - Surrogate keys in the dimension tables are unique.
    - Referential integrity holds between the fact and dimension tables.
    - Relationships in the data model are valid for analytical use.

Usage Notes:
    - Look into and fix any discrepancies these checks turn up.
===============================================================================
*/

-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================
-- Verify that Customer Key is unique in gold.dim_customers
-- Expectation: No results 
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.product_key'
-- ====================================================================
-- Verify that Product Key is unique in gold.dim_products
-- Expectation: No results 
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Verify that the fact table connects properly to the dimension tables
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL
