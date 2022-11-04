#!/usr/bin/env groovy
  
  def call(String url,String message,String status){
        office365ConnectorSend webhookUrl: "${url}", message: "${message}" , status: "${status}", color: "#000000"
    }