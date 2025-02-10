 read -p "Enter table name: " name
if [ -z "$name" ] 
then
    echo please enter table name
elif [ -f "db/$CURRENT_DB/$name" ]
then
    rm db/$CURRENT_DB/$name db/$CURRENT_DB/$name.meta
    echo table deleted successfully
else
    echo table does not exist
fi
