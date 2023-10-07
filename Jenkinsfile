pipeline {
    agent any
    stages {
        stage('SonarQube Analysis') {
            agent {
                docker {
                    image 'maven:3.8.4'
                    args '-v /var/run/docker.sock:/var/run/docker.sock' // Add Docker socket volume for Docker-in-Docker
                }
            }
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        // Set up Maven and run SonarQube analysis without a project key
                        sh '''
                            mvn clean package sonar:sonar \
                            -Dsonar.sources=src/main \
                            -Dsonar.host.url=http://100.26.131.174:9000
                        '''
                    }
                }
            }
        }
        stage('Quality Gate Status') {
            steps {
                script {
                    def qg = waitForQualityGate abortPipeline: false
                    if (qg.status != 'OK') {
                        error("Quality Gate did not pass: ${qg.status}")
                    }
                }
            }
        }
        stage('docker build & push to Nexus repo'){
            steps{
                scripts{
    }
}
