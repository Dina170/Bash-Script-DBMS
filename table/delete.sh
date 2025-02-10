#!/bin/bash
read -p "Enter Table Name: " name
if [[ ! -f "db/$CURRENT_DB/$name" ]]; 
then
    echo "Table does not exist!"
    return
fi

read -p "Enter Primary Key value to delete: " key
grep -v "^$key|" "db/$CURRENT_DB/$name" > "db/$CURRENT_DB/temp"

if [[ ! -s "db/$CURRENT_DB/temp" ]]
then
    rm "db/$CURRENT_DB/$name"
    echo "Table is now empty and deleted"
else
    mv "db/$CURRENT_DB/temp" "db/$CURRENT_DB/$name"
    echo "row deleted successfully"
fi

