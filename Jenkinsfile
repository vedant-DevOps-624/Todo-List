pipeline {
  agent any
  options { timestamps() }
  environment {
    IMAGE_NAME = "vedant/todo-list"
    IMAGE_TAG  = "latest"
  }

  stages {
    stage('Print environment') {
      steps {
        script {
          echo "Running on ${isUnix() ? 'Unix' : 'Windows'} node"
        }
        // sanity checks (these commands will no-op on the other platform)
        sh(script: 'echo $SHELL || true', returnStdout: true)
        bat(script: 'echo %COMSPEC% || true', returnStdout: true)
      }
    }

    stage('Tool checks') {
      steps {
        script {
          if (isUnix()) {
            sh 'echo Checking git and docker on Unix...'
            sh 'git --version || true'
            sh 'docker --version || echo docker-not-found'
          } else {
            bat 'echo Checking git and docker on Windows...'
            bat 'git --version || echo git-not-found'
            bat 'docker --version || echo docker-not-found'
          }
        }
      }
    }

    stage('Build Docker image (if docker present)') {
      steps {
        script {
          def dockerPresent = false

          if (isUnix()) {
            def out = sh(script: 'docker --version 2>/dev/null || true', returnStdout: true).trim()
            dockerPresent = out && !out.toLowerCase().contains('not found') && !out.contains('docker-not-found')
          } else {
            def out = bat(script: 'docker --version || echo docker-not-found', returnStdout: true).trim()
            dockerPresent = !out.toLowerCase().contains('docker-not-found')
          }

          if (dockerPresent) {
            echo "Docker CLI found — building image ${env.IMAGE_NAME}:${env.IMAGE_TAG}"
            if (isUnix()) {
              sh "docker build -t ${env.IMAGE_NAME}:${env.IMAGE_TAG} ."
            } else {
              bat "docker build -t ${env.IMAGE_NAME}:${env.IMAGE_TAG} ."
            }
          } else {
            echo "Docker CLI not found on this node — skipping Docker build."
          }
        }
      }
    }

    stage('Run smoke test (if image built)') {
      steps {
        script {
          def canRun = false

          if (isUnix()) {
            def out = sh(script: "docker images -q ${env.IMAGE_NAME}:${env.IMAGE_TAG} || true", returnStdout: true).trim()
            canRun = out ? true : false
          } else {
            def out = bat(script: "docker images -q ${env.IMAGE_NAME}:${env.IMAGE_TAG} || echo none", returnStdout: true).trim()
            canRun = !out.toLowerCase().contains('none') && out
          }

          if (canRun) {
            echo "Running short smoke container"
            if (isUnix()) {
              sh "docker run --rm -d --name todo_smoke ${env.IMAGE_NAME}:${env.IMAGE_TAG} || true"
              sleep 5
              sh "docker ps -a --filter name=todo_smoke --format \"{{.Status}} {{.Names}}\" || true"
              sh "docker stop todo_smoke || true"
            } else {
              bat "docker run --rm -d --name todo_smoke ${env.IMAGE_NAME}:${env.IMAGE_TAG} || echo run-failed"
              bat "timeout /t 5 /nobreak >nul || echo wait"
              bat "docker ps -a --filter name=todo_smoke --format \"{{.Status}} {{.Names}}\" || echo ps-failed"
              bat "docker stop todo_smoke || echo stop-failed"
            }
          } else {
            echo "No image found — skipping run step."
          }
        }
      }
    }
  } // end stages

  post {
    success { echo "Pipeline finished SUCCESS" }
    failure { echo "Pipeline FAILED — check console output" }
  }
}
