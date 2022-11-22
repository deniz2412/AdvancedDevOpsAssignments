#!/bin/bash

##add another location to read from in catalina.properties
cd ./tomcat/ || exit
sed -i '/common.loader/ s/$/&\,\"\$\{catalina\.home\}\/\.\.\/conf\"/' ./conf/catalina.properties

