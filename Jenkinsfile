pipeline {
    agent any
 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key') // Jenkins credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key') // Jenkins credentials ID
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
 
        // stage('Docker Build and Deploy to EC2') {
        //     steps {
        //         script {
        //             // Build Docker image
        //             bat 'docker build -t node-app .'
 
        //             // Save Docker image as tar
        //             bat 'docker save node-app -o node-app.tar'
 
        //             // Send image to EC2 (use your actual path and IP)
        //             bat 'pscp -i "C:\\Users\\pripandh\\Desktop\\your-key.ppk" node-app.tar ubuntu@<EC2-IP>:/home/ubuntu/'
 
        //             // SSH into EC2 and deploy container
        //             bat '''
        //             plink -i "C:\\Users\\your-username\\Desktop\\your-key.ppk" ubuntu@<EC2-IP> ^
        //             "docker load < node-app.tar && ^
        //             docker stop node-app || true && ^
        //             docker rm node-app || true && ^
        //             docker run -d -p 3000:3000 --name node-app node-app"
        //             '''
        //         }
        //     }
        // }
    }
}
