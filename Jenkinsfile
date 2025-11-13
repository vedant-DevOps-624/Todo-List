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
        // quick sanity
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
            sh 'docker --version || echo "docker-not-found"'
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
            dockerPresent = out && !out.toLowerCase().contains('not found') && !out.conta
