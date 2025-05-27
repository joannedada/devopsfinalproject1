pipeline {
    agent any
    triggers {
        pollSCM('* * * * *') 
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'project-2', 
                url: 'https://github.com/joannedada/devopsfinalproject1.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("joannedada/calculator")
                }
            }
        }
        stage('Deploy Container') {
            steps {
                sh 'docker stop calculator-app || true'
                sh 'docker rm calculator-app || true'
                sh 'docker run -d -p 8081:8080 --name calculator-app joannedada/calculator'
            }
        }
    }
}