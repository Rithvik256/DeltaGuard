CREATE OR REFRESH STREAMING TABLE deltaguard.bronze.products_bronze AS
SELECT *,
        current_timestamp() as processing_date,
        _metadata.file_name AS sorce_file
FROM cloud_files(
    '/Volumes/deltaguard/default/products/',
    'json',
    map(
        'cloudFiles.inferColumnTypes', 'true',
        'cloudFiles.schemaEvolutionMode', 'addNewColumns',
        'multiLine', 'true'
    )
);