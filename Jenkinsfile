pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops-static-site"
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo "🔹 CI/CD Pipeline started by Aditya Singh"
                echo "Cloning the repository (main branch)..."
                git branch: 'main', url: 'https://github.com/AdityaSingh0472/devops-static-website.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🔹 Building Docker image for Aditya's static website..."
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Run Container') {
            steps {
                echo "🔹 Deploying the latest version of the website..."
                sh 'docker stop devops-container || true && docker rm devops-container || true'
                sh "docker run -d --name devops-container -p 8080:80 ${IMAGE_NAME}"
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment successful!"
        }
        failure {
            echo "❌ Build or deployment failed — please check logs."
        }
    }
}