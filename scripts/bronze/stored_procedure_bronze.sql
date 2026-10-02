/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from CSV files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_starttime DATETIME, @batch_endtime DATETIME


SET @batch_starttime = GETDATE();
    BEGIN TRY
        PRINT '=====================================================';
        PRINT 'LOADING THE BRONZE LAYER ';
        PRINT '=====================================================';

        PRINT '--------------------------------------------------------';
        PRINT 'LOADING CRM TABLES ';
        PRINT '--------------------------------------------------------';

        PRINT '>> Truncating table: bronze.crm_cust_info '
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting Data in: bronze.crm_cust_info '
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\maxnj\Desktop\Data_warehouse_Project\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>  The Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';

        PRINT '>> Truncating table: bronze.crm_prd_info'
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>> Inserting Data in: bronze.crm_prd_info '
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\maxnj\Desktop\Data_warehouse_Project\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>  The Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';


        PRINT '>> Truncating table: bronze.crm_sales_details '
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>> Inserting Data in: bronze.crm_sales_details  '
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\maxnj\Desktop\Data_warehouse_Project\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>  The Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';


        PRINT '--------------------------------------------------------';
        PRINT 'LOADING ERP TABLES ';
        PRINT '--------------------------------------------------------';

        PRINT '>> Truncating table: bronze.erp_cust_az12 '
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT '>> Inserting Data in: bronze.erp_cust_az12 '
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\maxnj\Desktop\Data_warehouse_Project\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>  The Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';


        PRINT '>> Truncating table: bronze.erp_loc_a101 '
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>> Inserting Data in: bronze.erp_loc_a101 '
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\maxnj\Desktop\Data_warehouse_Project\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>  The Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';

        PRINT '>> Truncating table: bronze.erp_px_cat_g1v2'
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT '>> Inserting Data in: bronze.erp_px_cat_g1v2 '
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\maxnj\Desktop\Data_warehouse_Project\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>  The Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';


        SET @batch_endtime = GETDATE();
        PRINT '>>  The Total Batch Duration: ' + CAST(DATEDIFF(second, @batch_starttime, @batch_endtime) AS NVARCHAR) + ' seconds';
        PRINT '-----------------';
     END TRY
 BEGIN CATCH
    PRINT '=========================================='
    PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
    PRINT 'Error Message' + ERROR_MESSAGE();
    PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
    PRINT '=========================================='
END CATCH
 

END






