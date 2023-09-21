pipeline {
    agent any
    stages {
        stage('Lint Dockerfile') {
            steps {
                dir(path: env.BUILD_ID){
                    sh '''
                        ls -la
                        
                        # Menginstal hadolint
                        
                        curl -Lo hadolint https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64
                        chmod +x ./hadolint
                        
                        # Menjalankan hadolint terhadap berkas Dockerfile
                        
                        ./hadolint ./Dockerfile
                    '''
                }
            }
        }
        
        stage('Test App') {
            agent {
                docker {
                    image 'golang:1.15-alpine'
                }
            }
            steps {
                sh 'go test -v -short --count=1 $(go list ./...)'
            }
        }
        
        stage('Build and Push Image') {
            steps {
                dir(path: env.BUILD_ID){
                    sh 'docker build -t ghcr.io/evan-aja/karsajobs:latest .'
                    withCredentials([string(credentialsId: 'github-pat', variable: 'PAT')]) {
                        sh 'echo "$PAT" | docker login ghcr.io -u evan-aja --password-stdin'
                        sh 'docker push ghcr.io/evan-aja/karsajobs:latest'
                    }
                }
            }
        }
    }
}