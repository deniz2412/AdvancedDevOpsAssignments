#!/usr/bin/env groovy

def call(){
        junit checksName 'Tests', testResults: '**/target/surefire-reports/TEST-*.xml'
    }