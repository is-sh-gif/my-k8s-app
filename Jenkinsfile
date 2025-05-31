pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-k8s-app'                      // Name of your app
        REGISTRY = 'israr170/my-k8s-app'               // DockerHub repo
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/is-sh-gif/my-k8s-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${env.BUILD_ID}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-credentials-id') {
                        docker.image("${IMAGE_NAME}:${env.BUILD_ID}").push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    kubernetesDeploy(
                        configs: 'k8s/deployment.yaml',
                        kubeconfigId: 'kubeconfig-id'
                    )
                }
            }
        }
    }
}
