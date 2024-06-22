pipeline {
    agent any

    environment {
        //AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        //AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
        LAMBDA_NAME = 'new_func_debian'
        PYTHON_FILE = 'my_new_lambda.py'
        ZIP_FILE = 'my_new_lambda.zip'
        HANDLER = 'my_new_lambda.lambda_handler'
        RUNTIME = 'python3.8'
        ROLE_ARN = 'arn:aws:iam::489568735630:role/lambda_execution_role'
        REGION = 'us-east-1' // Cambia esto a tu región preferida
        AWS_CREDENTIALS_ID = 'ID_AKID_SECRET' // ID de las credenciales de AWS en Jenkins
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

        stage('Create lambda Zip') {
            steps {
                sh 'zip lambda_function.zip lambda_function.py'
            }
        }
        stage('Create AWS Lambda Function') {
            steps {
                withAWS(credentials: "${env.AWS_CREDENTIALS_ID}") {
                sh 'aws lambda create-function \
                    --function-name $LAMBDA_NAME \
                    --zip-file fileb://$ZIP_FILE \
                    --handler $HANDLER \
                    --runtime $RUNTIME \
                    --role $ROLE_ARN \
                    --region $REGION'
                }
        }
        stage('Clean Up') {
            steps {
                sh "rm -rf ${ZIP_FILE}"
            }
        }
        
/*
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

        stage('Plan Terraform Plan') {
            steps {
                sh 'terraform plan \
                    -var "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
                    -var "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
                    -var "key_name=key_pair" \
                    -var "private_key_path=key_pair.pem"'
            }
        }

        stage('Apply Terraform') {
            steps {
                sh  'terraform apply -auto-approve \
                    -var "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" \
                    -var "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" \
                    -var "key_name=key_pair" \
                    -var "private_key_path=key_pair.pem"'
            }
        }
    }
*/
}
}
