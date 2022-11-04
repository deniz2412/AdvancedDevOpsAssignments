#!/bin/sh
##Script creates 2 folders and pulls tomcat dir and prepares it
cd /mnt/c/Users/denizh/Desktop/AdvancedDevOpsAssignments/ || exit

mkdir -vp /mnt/c/Users/denizh/Desktop/AdvancedDevOpsAssignments/logicaldoc/config


curl -L https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.69/bin/apache-tomcat-9.0.69.tar.gz \
     -o /mnt/c/Users/denizh/Desktop/AdvancedDevOpsAssignments/logicaldoc/tomcat.tar.gz

cd ./logicaldoc || exit
tar -xf ./tomcat.tar.gz
mv apache-tomcat-9.0.69 tomcat
rm tomcat.tar.gz


##Context.props will be moved inside of Docker