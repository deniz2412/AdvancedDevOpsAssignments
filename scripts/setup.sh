#!/bin/sh
##Script creates 2 folders and pulls tomcat dir and prepares it
mkdir -vp conf

curl -L https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.69/bin/apache-tomcat-9.0.69.tar.gz \
     -o tomcat.tar.gz

tar -xf tomcat.tar.gz
mv apache-tomcat-9.0.69 tomcat
rm tomcat.tar.gz
