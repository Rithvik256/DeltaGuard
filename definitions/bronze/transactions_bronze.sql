CREATE OR REFRESH STREAMING TABLE deltaguard.bronze.transactions_bronze AS
SELECT *,
        current_timestamp() AS processing_time,
        _metadata.file_name AS source_file
FROM cloud_files(
    '/Volumes/deltaguard/default/transactions/',
    'json',
    map(
        'cloudFiles.inferColumnTypes', 'true',
        'cloudFiles.schemaEvolutionMode', 'addNewColumns',
        'multiLine', 'true'
    )
);