//  GroupName: TeamCDN (Chaitra Bekal, Dipak Meher, Nishad Main)
//  Jenkinsfile defines the pipeline in scm and here, there are 4 stages in 
//  this CICD pipeline: Build, Push to DockerHub, Deploying Rancher to single node, Deploying Rancher to Load Balancer 


@NonCPS
def generateTag() {
    return "build-" + new Date().format("yyyyMMdd-HHmmss")
}
// Pipeline Stages
pipeline {
    environment {
        registry = "dipakmeher51/studentsurvey645"
        registryCredential = 'docker'
    }
    agent any

    stages{
        //  Build Stage
        stage('Build') {
            steps {
                script {
                    checkout scm
                    sh 'rm -rf *.war'
                    sh 'jar -cvf StudentSurvey_DipakMeher645.war -C src/main/webapp/ .'
                    // sh 'echo ${BUILD TIMESTAMP}'
                    tag = generateTag()
                    docker.withRegistry('',registryCredential){
                    def customImage = docker.build("dipakmeher51/studentsurvey645:"+tag)
                   }
               }
            }
        }
        // Push to DockerHub Stage
        stage('Push to Docker Hub') {
            steps {
                script {
                    // sh 'echo ${BUILD_TIMESTAMP}'
                    docker.withRegistry('',registryCredential) {
                        def image = docker.build('dipakmeher51/studentsurvey645:'+tag, '.')
                        docker.withRegistry('',registryCredential) {
                            image.push()
                        }
                    }
                }
            }
        }
        // Deploying Rancher to single node
        stage('Deploying Rancher to single node') {
            steps {
                script{
                sh 'kubectl set image deployment/hw2-cluster-deployment container-0=dipakmeher51/studentsurvey645:'+tag
                }
            }
        }
        // Deploying Rancher to Load Balancer
        stage('Deploying Rancher to Load Balancer') {
            steps {
                script{
                    sh 'kubectl set image deployment/hw2-cluster-deploymentlb container-0=dipakmeher51/studentsurvey645:'+tag
                }
            }
        }
    }
}
