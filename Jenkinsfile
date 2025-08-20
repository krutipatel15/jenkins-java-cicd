pipeline {
  agent any
  
  tools {
    mvn
  }

  environment {
    APP='app'
}

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/krutipatel15/jenkins-java-cicd.git'
      }
    stage('build') {
      steps {
	dir('app/') {
	sh "mvn -f $(APP)/pom.xml -B -ntp -DskipTests package"    
    }
  }
}
