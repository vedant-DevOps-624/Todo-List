pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        script {
          if (isUnix()) {
            // on Linux/macOS agents
            sh '''
              echo "Building on Unix"
              docker build -t vedant/todo-list:latest .
            '''
          } else {
            // on Windows agents
            bat """
              echo Building on Windows
              REM If Docker CLI is available on Windows, build:
              docker build -t vedant/todo-list:latest .
            """
          }
        }
      }
    }

    stage('Run container') {
      when { expression { isUnix() } } // optional: only run on Unix agents if you expect docker there
      steps {
        sh 'docker run --rm -d -p 8080:80 vedant/todo-list:latest'
      }
    }
  }
  post {
    failure { echo 'Build or deployment failed — check logs.' }
  }
}
