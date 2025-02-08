#! /usr/bin/bash

read -p "Enter database name: " name
if [ -z $name ] 
then
    echo please enter database name
elif [ -d db/$name ]
then
    echo database already exists
elif [[ ! $name =~ ^[a-zA-Z][a-zA-Z0-9_]+$ ]]
then
    echo name can not contain special characters
else
    mkdir -p db/$name
    echo database created successfully
fi
