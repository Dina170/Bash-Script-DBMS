createtb() {
    read -p "Enter table name: " name
    if [ -z $name ] 
    then
        echo please enter table name
    elif [ -f db/$CURRENT_DB/$name ]
    then
        echo table already exists
    elif [[ ! $name =~ ^[a-zA-Z0-9]+$ ]]
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
}

droptb() {
    read -p "Enter table name: " name
    if [ -z $name ] 
    then
        echo please enter table name
    elif [ -f db/$CURRENT_DB/$name ]
    then
        rm db/$CURRENT_DB/$name db/$CURRENT_DB/$name.meta
        echo table deleted successfully
    else
        echo table does not exist
    fi
}

insertdata() {
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
}

select choice in "create table" "list tables" "drop table" "insert data" "exit"
do
        case $REPLY in
                1) createtb;;
                2) ls db/$CURRENT_DB | grep -v '\.meta$';;
                3) droptb;;
                4) insertdata;;
                5) exit;;
                *) echo not a valid option
        esac
done