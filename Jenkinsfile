@NonCPS
def generateTag() {
    return "build-" + new Date().format("yyyyMMdd-HHmmss")
}

pipeline {
    environment {
        registry = "dipakmeher51/studentsurvey645"
        registryCredential = 'docker'
    }
    agent any

    stages{

        stage('Build') {
            steps {
                script {
                    checkout scm
                    sh 'rm -rf *.war'
                    sh 'jar -cvf StudentSurvey_DipakMeher645.war -C WebContent/ .'
                    // sh 'echo ${BUILD TIMESTAMP}'
                    tag = generateTag()
                    docker.withRegistry('',registryCredential){
                    def customImage = docker.build("dipakmeher51/studentsurvey645:"+tag)
                   }
               }
            }
        }

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

      stage('Deploying Rancher to single node') {
            steps {
                script{
                sh 'kubectl set image deployment/hw2-cluster-deployment container-0=dipakmeher51/studentsurvey645:'+tag
                }
            }
        }

        stage('Deploying Rancher to Load Balancer') {
            steps {
                script{
                    sh 'kubectl set image deployment/surveyformlb container-0=dipakmeher51/studentsurvey645:'+tag
                }
            }
        }
    }
}
