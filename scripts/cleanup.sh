#!/bin/sh


cd /mnt/c/Users/denizh/Desktop/AdvancedDevOpsAssignments/logicaldoc/tomcat/webapps/ROOT

until [ -f ./detectmobile.jsp ]
do
     sleep 30
done
echo "File found"
exit
sed '7,$d' ./detectmobile.jsp
