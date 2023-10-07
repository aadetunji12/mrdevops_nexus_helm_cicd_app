pipeline {
    agent any
    stages {
        stage('SonarQube Analysis') {
            agent {
                docker {
                    image 'maven:3.8.4'
                }
            }
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        // Set up Maven and run SonarQube analysis without a project key
                        sh '''
                            mvn clean package sonar:sonar \
                            -Dsonar.sources=src/main \
                            -Dsonar.host.url=http://your-sonarqube-server:9000 \
                            -Dsonar.login=$SONAR_TOKEN
                        '''
                    }
                }
            }
        }
    }
}
