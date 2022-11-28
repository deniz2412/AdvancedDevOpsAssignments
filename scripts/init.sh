#!/bin/sh
nohup ./scripts/cleanup.sh &
./bin/catalina.sh run 
