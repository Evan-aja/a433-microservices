pipeline {
    agent any
    stages {
        stage('Lint Dockerfile') {
            steps {
                sh '''
                    # Menginstal hadolint
                    
                    curl -Lo hadolint https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64
                    chmod +x ./hadolint
                    
                    # Menjalankan hadolint terhadap berkas Dockerfile
                    
                    ./hadolint ./Dockerfile
                '''
            }
        }
        
        stage('Build and Push Image') {
            steps {
                sh 'docker build -t ghcr.io/evan-aja/karsajobs-ui:latest .'
                withCredentials([string(credentialsId: 'github-pat', variable: 'PAT')]) {
                    sh 'echo "$PAT" | docker login ghcr.io -u evan-aja --password-stdin'
                    sh 'docker push ghcr.io/evan-aja/karsajobs-ui:latest'
                }
            }
        }
    }
}