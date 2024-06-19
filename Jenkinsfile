pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Checkout Source Code') {
            steps {
                git branch: 'master', url: 'https://github.com/camilo-gdonoso/lambda_function.git'
            }
        }

        stage('Prepare Environment') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Package Lambda Function') {
            steps {
                sh 'zip lambda_function.zip lambda_function.py'
            }
        }

        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Format and Validate Terraform Code') {
            steps {
                sh 'terraform fmt && terraform validate'
            }
        }

        stage('Plan Terraform') {
            steps {
                sh '''
                    terraform plan \
                    -var "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
                    -var "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
                    -var "key_name=${params.key_name}" \
                    -var "private_key_path=${params.private_key_path}"
                '''
            }
        }

        stage('Apply Terraform') {
            steps {
                sh '''
                    terraform apply -auto-approve \
                    -var "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
                    -var "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
                    -var "key_name=${params.key_name}" \
                    -var "private_key_path=${params.private_key_path}"
                '''
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
