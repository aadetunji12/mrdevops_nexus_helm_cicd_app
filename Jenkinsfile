pipeline {
    agent any
    environment {
        // Define your image and version/tag
        DOCKER_IMAGE = 'aadeleke12/myweb'
        DOCKER_VERSION = '0.0.2'
        NEXUS_REPOSITORY = '54.160.104.186:8083/adeleke12'
        NEXUS_VERSION = '1.0.0'
    }
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
        stage('Build Docker Image') {
            steps {
                script {
                    // Use the correct path to your Dockerfile
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_VERSION} ."
                }
            }
        }
        stage('Docker Image Push') {
            steps {
                withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
                    sh "docker login -u aadeleke12 -p ${dockerPassword}"
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_VERSION}"
                }
            }
        }
        stage('Nexus Image Push') {
            steps {
                script {
                    sh "docker login -u admin -p alexandria1A! 54.160.104.186:8083"
                    sh "docker tag ${DOCKER_IMAGE}:${DOCKER_VERSION} ${NEXUS_REPOSITORY}:${NEXUS_VERSION}"
                    sh "docker push ${NEXUS_REPOSITORY}:${NEXUS_VERSION}"
                }
            }
        }
    }
}
