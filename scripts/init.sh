#!/bin/bash
set -m

./tomcat/bin/catalina.sh run &

./scripts/cleanup.sh

fg %1