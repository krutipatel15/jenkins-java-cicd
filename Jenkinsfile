pipeline {
    agent any

    tools {
        maven 'jenkins-maven'   // make sure you configured "M3" under Jenkins -> Global Tool Configuration
    }

    environment {
        APP = 'app'
        REGISTRY = 'krutipatel15'
        IMAGE_NAME = 'jenkins-java-image'
        DOCKER_TAG = '1.0'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/krutipatel15/jenkins-java-cicd.git'
            }
        }

        stage('Build') {
            steps {
                dir("${APP}") {
                    sh "mvn -f pom.xml -B -ntp -DskipTests package"
                }
            }
        }
        stage('Test') {
            steps {
                dir("${APP}") {
                    sh "mvn clean test"
                }
            }
        stage('Docker Build & Push') {
            steps {
              sh """
                docker build -t ${REGISTRY}/${IMAGE_NAME}:${DOCKER_TAG} .
                docker tag ${REGISTRY}/${IMAGE_NAME}:${DOCKER_TAG} ${REGISTRY}/${IMAGE_NAME}:latest
              """
            }
        }
        stage('Docker Build') {
            steps {
              sh """
                docker build -t ${REGISTRY}/${IMAGE_NAME}:${DOCKER_TAG} .
                docker tag ${REGISTRY}/${IMAGE_NAME}:${DOCKER_TAG} ${REGISTRY}/${IMAGE_NAME}:latest
              """
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: REGISTRY_CRED, usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin ${REGISTRY}'
                    sh 'docker push ${REGISTRY}/${IMAGE_NAME}:${DOCKER_TAG}'
                    sh 'docker push ${REGISTRY}/${IMAGE_NAME}:latest' 
            }
        }
    }
}
