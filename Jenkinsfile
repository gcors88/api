pipeline {
    agent any
    stages {
        stage('Building') {
            steps {
                script {
                    docker.withRegistry(
                        'https://268769556228.dkr.ecr.us-east-2.amazonaws.com',
                        'ecr:us-east-2:aws1'
                    ) {
                        def myImage = docker.build('rest-api')
                        myImage.push('rest-api')
                    }
                }
            }
        }
    }
}