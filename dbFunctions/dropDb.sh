#! /usr/bin/bash

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
