#!/bin/bash
read -p "Enter Table Name: " table_name
if [[ ! -f "$table_name.txt" ]]; then
    echo " Table does not exist!"
    exit 1
fi

read -p "Enter Primary Key value to delete: " key
grep -v "^$key|" "$table_name.txt" >temp.txt && mv temp.txt "$table_name.txt"
echo " Row deleted successfully"


