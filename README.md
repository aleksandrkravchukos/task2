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
    
## Step 1 - Create Database

    make create-database   