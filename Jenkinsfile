pipeline {
    agent any
    stages {
        stage('Building') {
            steps {
                sh 'docker build -t rest-api .'
                sh 'docker tag rest-api:latest 268769556228.dkr.ecr.us-east-2.amazonaws.com/rest-api:latest'
                sh 'docker push 268769556228.dkr.ecr.us-east-2.amazonaws.com/rest-api:latest'
            }
        }
    }
}