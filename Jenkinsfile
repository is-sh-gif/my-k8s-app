pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-k8s-app'                      // Name of your app
        REGISTRY = 'israr170/my-k8s-app'               // DockerHub repo
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
                    docker.build("${IMAGE_NAME}:${env.BUILD_ID}")
                }
            }
        }

stage('Push Docker Image') {
    steps {
        withDockerRegistry([credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/']) {
            script {
                def imageName = "israr170/my-k8s-app:${env.BUILD_NUMBER}"
                bat "docker tag my-k8s-app:${env.BUILD_NUMBER} ${imageName}"
                bat "docker push ${imageName}"
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
