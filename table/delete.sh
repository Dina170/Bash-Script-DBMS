#!/bin/bash
read -p "Enter Table Name: " name
if [[ ! -f "db/$CURRENT_DB/$name" ]]; 
then
    echo "Table does not exist!"
    exit 1
fi

read -p "Enter Primary Key value to delete: " key
grep -v "^$key|" "db/$CURRENT_DB/$name" >"db/$CURRENT_DB/temp" && mv "db/$CURRENT_DB/temp" "db/$CURRENT_DB/$name"
echo " Row deleted successfully"


