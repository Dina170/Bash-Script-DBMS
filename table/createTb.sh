read -p "Enter table name: " name
if [ -z $name ] 
then
    echo please enter table name
elif [ -f "db/$CURRENT_DB/$name" ]
then
    echo table already exists
elif [[ ! $name =~ ^[a-zA-Z][a-zA-Z0-9_]+$ ]]
then
    echo name can not contain special characters
else
    columns=()
    types=()

    read -p "enter primary key name: " pk
    read -p "enter primary key type[int/string]: " pktype

    columns+=($pk)
    types+=($pktype)
    while true
    do
        read -p "enter field name or done to exit: " field
        if [ $field == "done" ]
        then
            echo exiting table
            break
        fi
        read -p "enter field type[int/string]: " ftype

        columns+=($field)
        types+=($ftype)

    done
    
    touch db/$namedb/$CURRENT_DB/$name db/$CURRENT_DB/$name.meta
    echo "Columns: ${columns[*]}" > "db/$CURRENT_DB/$name.meta"
    echo "Types: ${types[*]}" >> "db/$CURRENT_DB/$name.meta"
    echo "PrimaryKey: $pk" >> "db/$CURRENT_DB/$name.meta"
    echo table created successfully
fi
