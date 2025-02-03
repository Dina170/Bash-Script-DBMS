#!/bin/bash
read -p "Enter Table Name: " table_name
if [[ ! -f "$table_name.txt" ]]; then
    echo "Table does not exist"
    exit 1
fi

echo "Table Data:"
column -t -s "|" "$table_name.txt"


