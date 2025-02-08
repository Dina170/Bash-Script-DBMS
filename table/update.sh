#!/bin/bash
read -p "Enter Table Name: " name
if [[ ! -f "db/$CURRENT_DB/$name" ]]; then
    echo "Table does not exist"
    exit 1
fi

#read -p "Enter Primary Key value to update: " key
#row=$(grep "^$key|" "db/$CURRENT_DB/$name")
#if [[ -z "$row" ]]; then
#    echo "Row not found"
#    exit 1
#fi

#echo "Current Data: $row"
columns=($(sed -n '1s/Columns: //p' db/$CURRENT_DB/$name.meta))
types=($(sed -n '2s/Types: //p' db/$CURRENT_DB/$name.meta))
pk=$(sed -n '3s/PrimaryKey: //p' db/$CURRENT_DB/$name.meta)

echo "Columns: ${columns[@]}"
read -p "Enter column to update: " column_name

#read -p "Enter new data (Name,Age): " new_data
#if [[ ! "$new_data" =~ "," ]]; then
#    echo " Please enter data in 'Name,Age' format"
#    exit 1
#fi

col_idx=-1

for col in "${!columns[@]}"
do
    if [[ "${columns[$col]}" == "$column_name" ]]
    then
    	echo test
    	col_idx=$((col+1))
    	dtype=${types[$col]}
    	break
    fi
done

if [ $col_idx -eq -1 ]
then
    echo "column does not exist"
    return
fi

read -p "Enter Primary Key value to update: " key
read -p "Enter new value to update: " new_value

if [[ "$dtype" == "int" && ! "$new_value" =~ ^[0-9]+$ ]]
then
    echo "Error: value must be an integer!"
    return
fi

#read -r new_name age <<< "$new_data"
awk -F "|" -v col_idx="$col_idx" -v key="$key" -v value="$new_value" '{
    if ($1 == key) {
        $col_idx=value;
    } 
    print $0;    
}' OFS='|' "db/$CURRENT_DB/$name" > "db/$CURRENT_DB/temp" && mv "db/$CURRENT_DB/temp" "db/$CURRENT_DB/$name"

echo "Row updated successfully"

