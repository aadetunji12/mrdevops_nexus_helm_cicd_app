pipeline {
    agent any
    environment {
        // Define environment variables if needed
        SONAR_SCANNER_HOME = tool name: 'SonarScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
    }
    stages {
        stage('Checkout') {
            steps {
                // Check out your source code repository here if not done already
                // For example: git checkout ...
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        // Use the SonarScanner tool configured in Jenkins
                        def scannerHome = tool 'SonarScanner'
                        sh "${scannerHome}/bin/sonar-scanner"
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
    }
}
