#!/bin/bash

##add another location to read from in catalina.properties
cd /mnt/c/Users/denizh/Desktop/AdvancedDevOpsAssignments/logicaldoc/tomcat/
sed -i '/common.loader/ s/$/&\,\"\$\{catalina\.home\}\/\.\.\/conf\"/' ./conf/catalina.properties

