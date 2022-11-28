#!/bin/sh
nohup ./scripts/cleanup.sh &
${CATALINA_HOME}/bin/catalina.sh run 
