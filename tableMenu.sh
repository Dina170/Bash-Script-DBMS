#! /usr/bin/bash
PS3="choose table option: "

select choice in "create table" "list tables" "drop table" "insert data" "select data" "select Where" "delete data" "update data" "back"
do
        case $REPLY in
                1) . table/createTb.sh;;
                2) ls db/$CURRENT_DB | grep -v '\.meta$';;
                3) . table/dropTb.sh;;
                4) . table/insert.sh;;
                5) . table/select.sh;;
                6) . table/selectWh.sh;;
                7) . table/delete.sh;;
                8) . table/update.sh;;
                9) break;;
                *) echo not a valid option
        esac
done
