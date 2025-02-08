#!/bin/bash
read -p "Enter Table Name: " name
if [[ ! -f "db/$CURRENT_DB/$name" ]]; then
    echo "Table does not exist"
    exit 1
fi

echo "Table Data:"
cat "db/$CURRENT_DB/$name"




