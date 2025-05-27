pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "joannedada/calculator"
        KUBE_NAMESPACE = "calculator-app"
        // Store Docker Hub credentials in Jenkins Credentials Store (ID: 'dockerhub-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'project-3', 
                url: 'https://github.com/joannedada/devopsfinalproject1.git'
            }
        }

        stage('Build & Push to Docker Hub') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push()
                        docker.image("${DOCKER_IMAGE}:${env.BUILD_ID}").push('latest')  // Optional: Also tag as latest
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Apply Kubernetes manifests
                    sh """
                        kubectl apply -f kubernetes/namespace.yml
                        sed -i 's|IMAGE_TAG|${env.BUILD_ID}|g' kubernetes/deployment.yml
                        kubectl apply -f kubernetes/deployment.yml
                        kubectl apply -f kubernetes/service.yml
                    """
                    
                    // Verify deployment
                    sh "kubectl rollout status deployment/calculator -n ${KUBE_NAMESPACE}"
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    def LB_DNS = sh(
                        script: "kubectl get svc calculator-service -n ${KUBE_NAMESPACE} -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'",
                        returnStdout: true
                    ).trim()
                    
                    echo "Application available at: http://${LB_DNS}"
                    sh "curl -v http://${LB_DNS}"
                }
            }
        }
    }
}