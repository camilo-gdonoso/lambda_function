pipeline {
    agent any

    environment {
        //AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        //AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-1'
        LAMBDA_NAME = 'new_func_aws'
        PYTHON_FILE = 'my_new_lambda.py'
        //ZIP_FILE = 'my_new_lambda.zip'
        HANDLER = 'my_new_lambda.lambda_handler'
        RUNTIME = 'python3.8'
        ROLE_ARN = 'arn:aws:iam::767397712182:role/lambda_execution_role'
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
                sh 'zip my_new_lambda.zip my_new_lambda.py'
            }
        }
        stage('Create AWS Lambda Function') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'ID_AKID_SECRET', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                sh '''
                export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                aws lambda create-function \
                    --function-name $LAMBDA_NAME \
                    --zip-file fileb://my_new_lambda.zip \
                    --handler $HANDLER \
                    --runtime $RUNTIME \
                    --role $ROLE_ARN \
                    --region $REGION
            '''
                }
            }
        }	
        
        }
    }

