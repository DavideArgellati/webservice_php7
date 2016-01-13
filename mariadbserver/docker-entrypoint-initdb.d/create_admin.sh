#!/bin/bash

#this script is in case there are permission issues wuth the default user creation
#ussually related to the host

#/usr/bin/mysqld_safe > /dev/null 2>&1 &

#RET=1
#while [[ RET -ne 0 ]]; do
#    echo "=> Waiting for confirmation of MariaDB service startup"
#    sleep 5
#    mysql -uroot -e "status" > /dev/null 2>&1
#    RET=$?
#done
#
#USER=${MYSQL_USER}
#PASS=${MYSQL_PASSWORD}
#echo "=> Creating MariaDB admin user with password"
#
#mysql -uroot -e "CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS'"
#mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION"
#mysql -uroot -e "CREATE USER '$USER'@'172.17%' IDENTIFIED BY '$PASS'"
#mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$USER'@'172.17%' WITH GRANT OPTION"
#
#echo "=> Done!"
#
#echo "========================================================================"
#echo "You can now connect to this MariaDB Server using:"
#echo ""
#echo "    mysql -u$USER -p$PASS -h<host> -P<port>"
#echo ""
#echo "Please remember to change the above password as soon as possible!"
#echo "MariaDB user 'root' has no password but only allows local connections"
#echo "========================================================================"
#
#mysqladmin -uroot shutdown
