pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-k8s-app'
        REGISTRY = 'israr170/my-k8s-app'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/is-sh-gif/my-k8s-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "${REGISTRY}:${env.BUILD_NUMBER}"
                    docker.build(imageName)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/']) {
                    script {
                        def imageName = "${REGISTRY}:${env.BUILD_NUMBER}"
                        docker.image(imageName).push()
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
