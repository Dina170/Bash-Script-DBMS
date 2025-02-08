#! /usr/bin/bash
PS3="choose db option: "

select choice in "create db" "list dbs" "connect to db" "drop db" "exit"
do
        case $REPLY in
                1) . dbFunctions/createDb.sh;;
                2) ls db;;
                3) . dbFunctions/connectDb.sh;;
                4) . dbFunctions/dropDb.sh;;
                5) exit;;
                *) echo not a valid option
        esac
done
