pipeline {
  agent any
  stages {
    stage('Checkout') { steps { checkout scm } }

    stage('Build Docker Image') {
      steps {
        script {
          if (isUnix()) {
            sh 'docker build -t vedant/static-site .'
          } else {
            // Windows
            bat 'docker build -t vedant/static-site .'
          }
        }
      }
    }

    stage('Run Container') {
      steps {
        script {
          if (isUnix()) {
            sh 'docker run -d -p 8080:80 --name static-site vedant/static-site'
          } else {
            bat 'docker run -d -p 8080:80 --name static-site vedant/static-site'
          }
        }
      }
    }
  }
}
