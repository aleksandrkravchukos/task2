# Task 2 

Given we have a MySQL DB and a table.
We need to backup table's data every month to another table.

## Solution explanation

The idea is to partition table monthly and backup by detaching the partition from main table and attaching to archive table.

## Prerequisites

Install Docker and optionally Make utility.

Commands from Makefile could be executed manually in case Make utility is not installed.

## Run docker with mysql

    docker-compose up -d
    
## Check docker containers

    docker ps    
    
## Create Project Layout

Creates test_log table, partitioned by month, and  nop partitioned test_log_backup table.
Also creates 2 stored procedures that help tocreate new partitions and move partition from main table to backup.

    make create-project
    
## Backup data

Moves partition from main table to backup.

     make move-partition database=test tablename_from=test_log tablename_to=test_log_backup partition_field=created_month partition_month_value=202005   
     
## Create new partitions on main table ( schedule on cron before next month start)

The below example creates partition for July 2020.

     make create-partition database=test tablename=test_log partition_month_value=202007   