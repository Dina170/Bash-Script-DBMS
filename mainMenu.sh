#! /usr/bin/bash
createdb () {
    read -p "Enter database name: " name
    if [ -z $name ] 
    then
        echo please enter database name
    elif [ -d db/$name ]
    then
        echo database already exists
    elif [[ ! $name =~ ^[a-zA-Z0-9]+$ ]]
    then
        echo name can not contain special characters
    else
        mkdir -p db/$name
        echo database created successfully
    fi
} 

connectTodb() {
    read -p "Enter database name: " name
    if [ -z $name ] 
    then
        echo please enter database name
    elif [ -d db/$name ]
    then
        CURRENT_DB=$name
        echo connected to $name
        . ./tablesMenu.sh
    else
        echo database does not exist
    fi
}

dropdb() {
    read -p "Enter database name: " name
    if [ -z $name ] 
    then
        echo please enter database name
    elif [ -d db/$name ]
    then
        rm -r db/$name
        echo database dropped
    else
        echo database does not exist
    fi
}

select choice in "create db" "list dbs" "connect to db" "drop db" "exit"
do
        case $REPLY in
                1) createdb;;
                2) ls db;;
                3) connectTodb;;
                4) dropdb;;
                5) exit;;
                *) echo not a valid option
        esac
done
