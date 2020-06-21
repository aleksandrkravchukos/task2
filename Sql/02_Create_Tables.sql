USE test;

DROP TABLE IF EXISTS test_log;
DROP TABLE IF EXISTS test_log_backup;

CREATE TABLE test_log
(
    created       datetime,
    created_month char(6),
    msg           varchar(2000)
) PARTITION BY LIST COLUMNS (created_month)(
    PARTITION p202005 VALUES IN ('202005'),
    PARTITION p202006 VALUES IN ('202006')
);

CREATE TABLE test_log_backup LIKE test_log;

ALTER TABLE test_log_backup REMOVE PARTITIONING;

INSERT INTO test_log VALUES ('2020-05-01 02:12:05', '202005', 'hi');
INSERT INTO test_log VALUES ('2020-05-01 04:12:15', '202005', 'ni');
INSERT INTO test_log VALUES ('2020-06-01 07:14:10', '202006', 'hao');