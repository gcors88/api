pipeline {
    agent any
    stages {
        stage('Building') {
            steps {
                echo 'DOCKER_USER'
                echo 'DOCKER_PASSWORD'
                sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 268769556228.dkr.ecr.us-east-2.amazonaws.com'
                sh 'docker build -t rest-api .'
                sh 'docker tag rest-api:latest 268769556228.dkr.ecr.us-east-2.amazonaws.com/rest-api:latest'
                sh 'docker push 268769556228.dkr.ecr.us-east-2.amazonaws.com/rest-api:latest'
            }
        }
    }
}