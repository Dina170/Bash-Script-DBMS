#!/bin/bash
read -p "Enter Table Name: " name
if [[ ! -f "db/$CURRENT_DB/$name" ]]; then
    echo "Table does not exist"
    return
fi

columns=($(sed -n '1s/Columns: //p' db/$CURRENT_DB/$name.meta))

echo "Columns: ${columns[@]}"
read -p "Enter column to search: " column_name
read -p "Enter value to search: " column_value


col_idx=-1

for col in "${!columns[@]}"
do
    if [[ "${columns[$col]}" == "$column_name" ]]
    then
    	col_idx=$((col+1))
    	break
    fi
done

if [ $col_idx -eq -1 ]
then
    echo "column does not exist"
    return
fi

awk -F "|" -v col_idx="$col_idx" -v value="$column_value" '$col_idx == value {print $0}' db/$CURRENT_DB/$name
    


