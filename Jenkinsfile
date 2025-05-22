pipeline {
    agent any
    triggers {
        pollSCM('* * * * *') 
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'project-1', 
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
                sh 'docker run -d -p 8080:8081 --name calculator-app joannedada/calculator'
            }
        }
    }
}