## Create database
create-database:
	docker exec -i db_move_partition mysql -u root -proot < Sql/01_Create_Database.sql

## Create tables
create-tables:
	docker exec -i db_move_partition mysql -u root -proot < Sql/02_Create_Tables.sql

## Show partitions on main table
show-partitions-main-table:
	docker exec -i db_move_partition mysql -u root -proot < Sql/03_Show_Partitions_Main_Table.sql

## Create stored procedure that adds partitions
create-stored_procedure:
	docker exec -i db_move_partition mysql -u root -proot < Sql/04_Stored_Procedure_Add_Partition.sql