pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'prod'], description: 'Target environment for provisioning')
        choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Terraform action to perform')
        string(name: 'PROJECT_ID', defaultValue: 'india-times-482008', description: 'GCP Project ID to provision resources in')
        booleanParam(name: 'RUN_BOOTSTRAP', defaultValue: false, description: 'Provision the GCS remote state bucket first (usually run once)')
        booleanParam(name: 'AUTO_APPROVE', defaultValue: false, description: 'Automatically approve apply/destroy changes (not recommended for production)')
    }

    environment {
        // ID of the Jenkins Secret File credential containing the GCP Service Account Key JSON
        GCP_CREDS_KEY = 'gcp-credentials'
        GOOGLE_APPLICATION_CREDENTIALS = credentials("${GCP_CREDS_KEY}")
        
        // Pass project ID parameter to Terraform
        TF_VAR_project_id = "${params.PROJECT_ID}"
        TF_IN_AUTOMATION = 'true'
        
        // Target Directories
        ENV_DIR = "environments/${params.ENVIRONMENT}"
        BOOTSTRAP_DIR = "bootstrap/remote-state"
    }

    stages {
        stage('Checkout') {
            steps {
                cleanWs()
                checkout([$class: 'GitSCM', 
                    branches: [[name: '*/main']], 
                    userRemoteConfigs: [[
                        url: 'https://github.com/celestibia-project/web-application-for-testing.git', 
                        credentialsId: 'GitHub-creds'
                    ]]
                ])
            }
        }

        stage('Format Check') {
            steps {
                echo "Checking Terraform code format..."
                sh 'terraform fmt -check -recursive'
            }
        }

        stage('Bootstrap State Bucket') {
            when {
                expression { params.RUN_BOOTSTRAP == true }
            }
            steps {
                echo "Initializing and applying remote state bootstrap..."
                dir("${BOOTSTRAP_DIR}") {
                    sh 'terraform init'
                    sh 'terraform plan -out=bootstrap.tfplan'
                    sh 'terraform apply -auto-approve bootstrap.tfplan'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                echo "Initializing Terraform for ${params.ENVIRONMENT}..."
                dir("${ENV_DIR}") {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                echo "Validating Terraform configuration..."
                dir("${ENV_DIR}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                echo "Generating Terraform plan..."
                dir("${ENV_DIR}") {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Manual Approval') {
            when {
                expression { 
                    (params.ACTION == 'apply' || params.ACTION == 'destroy') && params.AUTO_APPROVE == false 
                }
            }
            steps {
                input message: "Approve Terraform ${params.ACTION} for ${params.ENVIRONMENT}?", ok: "Proceed"
            }
        }

        stage('Terraform Apply / Destroy') {
            when {
                expression { params.ACTION == 'apply' || params.ACTION == 'destroy' }
            }
            steps {
                echo "Applying Terraform changes..."
                dir("${ENV_DIR}") {
                    script {
                        if (params.ACTION == 'apply') {
                            sh 'terraform apply -auto-approve tfplan'
                        } else if (params.ACTION == 'destroy') {
                            sh 'terraform destroy -auto-approve'
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up plan files and workspace..."
            sh "rm -f ${ENV_DIR}/tfplan"
            sh "rm -f ${BOOTSTRAP_DIR}/bootstrap.tfplan"
            cleanWs()
        }
        success {
            echo "Pipeline run completed successfully!"
        }
        failure {
            echo "Pipeline run failed. Please check the logs."
        }
    }
}
