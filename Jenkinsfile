pipeline {
    agent any
    stages {
        stage('Building') {
            steps {
                sh 'docker login -u cobaia321 -p cobaia*123'
                sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 268769556228.dkr.ecr.us-east-2.amazonaws.com'
                sh 'docker build -t rest-api .'
                sh 'docker tag rest-api:latest 268769556228.dkr.ecr.us-east-2.amazonaws.com/rest-api:latest'
                sh 'docker push 268769556228.dkr.ecr.us-east-2.amazonaws.com/rest-api:latest'
            }
        }
    }
}