package lib

public class someReusableMethods implements Serializable{
    def steps
    someReusableMethods(steps){
    this.steps = steps
}
    def gitCheckoutBranch(String branch, String credsId, String url){
        steps.git url: "${url}", credentialsId: "${credsId}", branch: "${branch}"
        steps.echo "Branch ${branch} checked"
        }

    def useMaven(String args){
        steps.sh "${steps.tool 'maven'}/bin/mvn -o ${args}"
    }

  
    
}