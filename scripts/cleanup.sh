#!/bin/sh

until [ -f ./tomcat/webapps/logicaldoc/detectmobile.jsp ]
do
     sleep 30
done
echo "File found"

sed -i '7,$d' ./tomcat/webapps/logicaldoc/detectmobile.jsp
exit
