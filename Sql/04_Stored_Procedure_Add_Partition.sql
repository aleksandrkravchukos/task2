use test;

DELIMITER ||
-- Delete stored procedures
drop procedure if exists create_partition_by_month_if_not_exist ||
-- Note: Using this stored procedure, you must ensure that there is at least one manual partition in the corresponding database table
-- Create stored procedures[Through database name and corresponding table name]-How many partitions are built and how many partition intervals are there?
-- databasename: Create partitioned databases
-- tablename: Name of the table that created the partition
create procedure create_partition_by_month_if_not_exist (in databasename varchar(50),in tablename varchar(50), in partition_month_value char(6))
L_END:
begin
    declare is_table_partitioned varchar(255) default 0;

    -- Check whether the corresponding database tables have been partitioned manually[Automatic partitioning requires manual partitioning]
    select partition_name into is_table_partitioned from information_schema.partitions where table_schema = databasename and table_name = tablename limit 1;
    -- If not, print the error and exit the stored procedure
    if is_table_partitioned <=> "" then
        select "table is not partitioned" as "ERROR";
        leave L_END;
    end if;

    -- ALTER TABLE TABLENAME ADD PARTITION ( PARTITION _partition_month_value_ VALUES IN (_partition_month_value_));
    set @sql=CONCAT('ALTER TABLE ', tablename ,' ADD PARTITION ( PARTITION p', partition_month_value ,' VALUES IN (\'', partition_month_value ,'\'))');
    -- Printing sql variable
    select @sql;
    -- Get ready sql Sentence
    PREPARE stmt from @sql;
    -- implement sql Sentence
    EXECUTE stmt;
    -- Release resources
    DEALLOCATE PREPARE stmt;

end ||
-- Recovery statement interrupt
DELIMITER ;