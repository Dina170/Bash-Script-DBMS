#! /usr/bin/bash

read -p "Enter database name: " name
if [ -z $name ] 
then
    echo please enter database name
elif [ -d db/$name ]
then
    CURRENT_DB=$name
    echo connected to $name
    . ./tableMenu.sh
else
    echo database does not exist
fi
