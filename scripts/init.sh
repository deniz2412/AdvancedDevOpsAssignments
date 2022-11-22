#!/bin/bash
nohup ./scripts/cleanup.sh &
./tomcat/bin/catalina.sh run 
