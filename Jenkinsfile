pipeline {
    agent any
 
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')    // Replace with your Jenkins credential ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key') // Replace with your Jenkins credential ID
    }
 
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
 
        stage('Checkout Terraform Repo') {
            steps {
                dir('terraform') {
git url: 'https://github.com/thakare-priyanka/jenkins-node-app', branch: 'main'
                }
            }
        }
 
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    bat 'terraform init -reconfigure'
                }
            }
        }
 
        stage('Approval') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                input message: 'Do you want to proceed with Apply?', ok: 'Yes'
            }
        }
 
        stage('Apply') {
            when {
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                dir('terraform') {
                    bat 'terraform apply -auto-approve'
                }
            }
        }
    }
}
