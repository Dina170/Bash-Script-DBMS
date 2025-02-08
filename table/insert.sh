read -p "Enter table name: " name
if [ -z $name ] 
then
echo please enter table name
elif [ -f db/$CURRENT_DB/$name ]
then
columns=($(sed -n '1s/Columns: //p' db/$CURRENT_DB/$name.meta))
types=($(sed -n '2s/Types: //p' db/$CURRENT_DB/$name.meta))
pk=$(sed -n '3s/PrimaryKey: //p' db/$CURRENT_DB/$name.meta)

values=()

for i in "${!columns[@]}"; do
while true; do
    read -p "Enter value for ${columns[i]} (${types[i]}): " value
    
    # Check data type
    if [[ "${types[i]}" == "int" && ! "$value" =~ ^[0-9]+$ ]]; then
        echo "Error: ${columns[i]} must be an integer!"
        continue
    fi

    # Check primary key uniqueness
    if [[ "${columns[i]}" == "$pk" ]]; then
        if grep -q "^$value|" "db/$CURRENT_DB/$name"; then
            echo Error: Primary key $value already exists
            continue
        fi
    fi

    values+=("$value")
    break
done
done

# Save data (separated by "|")
echo "${values[*]}" | tr ' ' '|' >> "db/$CURRENT_DB/$name"
echo data inserted successfully
else
echo table does not exist
fi

