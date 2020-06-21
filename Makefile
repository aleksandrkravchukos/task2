## Create project
create-project:
	make create-database
	make create-tables
	make create-stored-procedure-create-partition
	make create-stored-procedure-move-partition

## Create database
create-database:
	docker exec -i db_task2 mysql -u root -proot < Sql/01_Create_Database.sql

## Create tables
create-tables:
	docker exec -i db_task2 mysql -u root -proot < Sql/02_Create_Tables.sql

## Show partitions on main table
show-partitions-main-table:
	docker exec -i db_task2 mysql -u root -proot < Sql/03_Show_Partitions_Main_Table.sql

## Create stored procedure that adds partitions
create-stored-procedure-create-partition:
	docker exec -i db_task2 mysql -u root -proot < Sql/04_Stored_Procedure_Add_Partition.sql

## Create stored procedure that moves partition
create-stored-procedure-move-partition:
	docker exec -i db_task2 mysql -u root -proot < Sql/05_Stored_Procedure_Move_Partition.sql

## Create partition using stored procedure
create-partition:
	docker exec -i db_task2 mysql -u root -proot test -e "call create_partition_by_month('$(database)', '$(tablename)', '$(partition_month_value)')"

## Create partition using stored procedure
move-partition:
	docker exec -i db_task2 mysql -u root -proot test -e "call move_partition_if_has_data_by_month('$(database)', '$(tablename_from)', '$(tablename_to)', '$(partition_month_value)')"