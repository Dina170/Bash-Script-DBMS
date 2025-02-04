#!/bin/bash
read -p "Enter Table Name: " table_name
if [[ ! -f "$table_name.txt" ]]; then
    echo "Table does not exist"
    exit 1
fi

read -p "Enter Primary Key value to update: " key
row=$(grep "^$key|" "$table_name.txt")
if [[ -z "$row" ]]; then
    echo "Row not found"
    exit 1
fi

echo "Current Data: $row"
read -p "Enter new data (Name,Age): " new_data
if [[ ! "$new_data" =~ "," ]]; then
    echo " Please enter data in 'Name,Age' format"
    exit 1
fi

IFS=',' read -r name age <<< "$new_data"
awk -F"|" -v key="$key" -v name="$name" -v age="$age" '{
    if ($1 == key) {
        print key "|" name "|" age;
    } else {
        print $0;
    }
}' "$table_name.txt" > temp.txt && mv temp.txt "$table_name.txt"

echo "Row updated successfully"

