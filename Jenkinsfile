pipeline{
    agent any
    environment{
        DOCKERHUB_PASS = credentials('docker')
    }
    stages{
        stage{'Building the Student Survey Image'}{
            steps{
                script{
                    checkout scm
                    sh 'rm -rf *.war'
                    sh 'jar -cvf StudentSurvey_DipakMeher645.war -C WebContent/ .'
                    sh 'echo ${BUILD TIMESTAMP}'
                    sh "docker login -u dipakmeher51 -p ${DOCKERHUB_PASS}"
                    def customImage = docker.build("dipakmeher51/studentsurvey645:${BUILD_TIMESTAMP}")
                }
            }
        }
    }
    stage('Pushing Image to DockerHub'){
        steps{
            script{
                sh 'docker push dipakmeher51/studentsurvey645:${BUILD_TIMESTAMP}'
            }
        }
    }
    stage('Deploying to Rancher as single pod'){
        steps{
            sh 'kubectl set image deployment/stusurvey-pipeline stusurvey-pipeline=dipakmeher51/studentsurvey645:${BUILD_TIMESTAMP} -n jenkins-pipeline'
        }
    }
    stage('Deploying to Rancher as with load balancer'){
        steps{
            sh 'kubectl set image deployment/studentsurvey645-lb studentsurvey645-lb=dipakmeher51/studentsurvey645:${BUILD_TIMESTAMP} -n jenkins-pipeline'
        }
    }
}