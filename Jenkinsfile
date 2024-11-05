pipeline {
    agent any
    environment {
        AWS_REGION = 'us-west-2'
        AWS_ECR_REPO = 'your-account-id.dkr.ecr.us-west-2.amazonaws.com/my-microservice'
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${AWS_ECR_REPO}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push to AWS ECR') {
            steps {
                script {
                    docker.withRegistry("https://${AWS_ECR_REPO}", 'aws-ecr-credentials') {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                ansiblePlaybook credentialsId: 'aws-ecr-credentials', playbook: 'ansible/deploy.yml'
            }
        }
    }
}
