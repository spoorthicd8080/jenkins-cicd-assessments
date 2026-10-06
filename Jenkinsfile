pipeline {

    agent any

    environment {
        FRONTEND_IMAGE = "jenkins-assessment-frontend:1.0"
        BACKEND_IMAGE  = "jenkins-assessment-backend:1.0"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Backend Test') {
            steps {
                bat '''
                docker run --rm -v "%CD%\\backend:/app" -w /app python:3.11-slim sh -c "pip install -r requirements.txt && python -m unittest test_app.py"
                '''
            }
        }

        stage('Build Docker Images') {
            steps {
                bat 'docker compose build'
            }
        }

        stage('Trivy Security Scan') {
            steps {
                bat '''
                trivy image --format table --output reports\\backend-trivy-report.txt %BACKEND_IMAGE%
                trivy image --format table --output reports\\frontend-trivy-report.txt %FRONTEND_IMAGE%
                '''
            }
        }

        stage('Deploy') {
            steps {
                bat 'docker compose up -d'
            }
        }

        stage('Health Check') {
            steps {
                bat '''
                timeout /t 15 /nobreak
                curl -f http://localhost:8081
                curl -f http://localhost:5001/health
                '''
            }
        }

        stage('Docker Cleanup') {
            steps {
                bat 'docker image prune -f'
            }
        }
    }

    post {

        always {
            archiveArtifacts artifacts: 'reports/*.txt',
                               allowEmptyArchive: true
        }

        success {
            echo 'Jenkins CI/CD pipeline completed successfully!'
        }

        failure {
            echo 'Jenkins CI/CD pipeline failed. Check the console output.'
        }
    }
}