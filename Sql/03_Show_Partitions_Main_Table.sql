USE test;

SELECT partition_name, partition_description AS val
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 'test_log' AND TABLE_SCHEMA = 'test';