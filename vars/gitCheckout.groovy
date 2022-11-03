#!/usr/bin/env groovy

def call(String branch,String credsId,String url){
     git(
        url: "${url}",
        credentialsId: "${credsId}",
        branch: "${branch}"
        )
        echo 'Branch $branch checked'

}
