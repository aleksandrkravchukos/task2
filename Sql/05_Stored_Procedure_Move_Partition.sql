use test;

DELIMITER ||
-- Delete stored procedures
drop procedure if exists move_partition_if_has_data_by_month ||
-- databasename: Create partitioned databases
-- tablename_from: Name of the table that partition is moved from
-- tablename_to: Name of the table that partition is moved to
-- partition_month_value: month value in format YYYYMM i.e. 202007
create procedure move_partition_if_has_data_by_month (in databasename varchar(50), in tablename_from varchar(50), in tablename_to varchar(50), in partition_month_value char(6))
L_END:
begin
    declare is_partition_not_empty varchar(255) default '';

    SELECT created_month INTO is_partition_not_empty FROM test_log PARTITION (p202006);

    SELECT concat('is_partition_not_empty is ', is_partition_not_empty);

    -- If not, print the error and exit the stored procedure
    if is_partition_not_empty <=> "" then
        select "from table partition is empty, do not moving it" as "ERROR";
        leave L_END;
    end if;

    -- ALTER TABLE tablename_from EXCHANGE PARTITION p_partition_month_value_ WITH TABLE _tablename_to_;
    set @sql=CONCAT('ALTER TABLE ', tablename_from ,' EXCHANGE PARTITION  p', partition_month_value ,' WITH TABLE ', tablename_to ,'');
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