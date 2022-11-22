def app
pipeline {
    agent {
  label 'worker-01'
}
environment{
    regCreds = 'dockerCred'
}
    tools {
        jdk 'JDK'
        maven "mvn"
        ant 'ant'
    }

    stages {
        stage('Checkout SCMs') {
            steps {
                cleanWs()
                dir("community"){
                    checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: 'master']], extensions: [], userRemoteConfigs: [[credentialsId: 'git', url: 'git@github.com:logicaldoc/community.git']]]
                }
                dir("build"){
                    checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[credentialsId: 'git', url: 'git@github.com:logicaldoc/build.git']]]
                }
               
            }
        }
        //Repositories and that
        stage('Install Parent POM'){
            steps{
                dir('build/poms') {
                sh 'mvn clean install'
                }
            }
        }
        stage('Validate Services'){
            steps{
                dir('community') {
                sh 'mvn validate'

               }
            }
        }
        stage('Compile Services'){
            steps{
                dir('community') {
                sh 'mvn compile'

               }
            }
        }
        stage('Unit Test Services'){
            steps{
                dir('community') {
                sh 'mvn -T 5 -Dmaven.test.failure.ignore=true test'

               }
            }
        }
        stage('Package Services'){
            steps{
                dir('community') {
                sh 'mvn -Dmaven.test.skip=true package'

               }
            }
        }
        stage('Integration test'){
            steps{
                dir('community') {
                sh 'mvn -T 5 -Dmaven.test.failure.ignore=true verify'
               }
            }
        }
        stage('Install Services'){
            steps{
                dir('community') {
                sh 'mvn clean -Dmaven.test.skip=true install'
               }
            }
        }
        stage('Prepare delivery env'){
            steps{
                dir('delivery'){                    
                    checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[credentialsId: 'git', url: 'git@github.com:deniz2412/AdvancedDevOpsAssignments.git']]]
                    sh 'mv ../community/logicaldoc-webapp/target/logicaldoc-webapp-8.8.3.war ./logicaldoc.war'
                }
            }
        }
        stage('Build Docker image'){
            steps{
                dir('delivery'){
                    script{
                        app=docker.build("denizh2412/ld")    
                    }
                    
            }
        }
        }
        stage('Push image'){
            steps{
                dir('delivery'){
                    script{
                        docker.withRegistry('https://registry.hub.docker.com', regCreds) {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                    
                }
                }
            }
        }
    }
}