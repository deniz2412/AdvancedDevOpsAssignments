#!/bin/sh
nohup ./scripts/cleanup.sh &
./tomcat/bin/catalina.sh run 
