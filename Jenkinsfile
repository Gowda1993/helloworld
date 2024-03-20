pipeline {
    agent { label 'slave01' }

    stages {
        stage('checkout') {
            steps {
                sh 'rm -rf hello-world-war'
                sh 'git clone https://github.com/gshashi1408/hello-world-war.git'
            }
        }
        
        stage('build') {
            steps {
                dir("hello-world-war") {
                    sh 'echo "inside build"'
                    sh "docker build -t tomcat-war:${BUILD_NUMBER} ."
                }
            }
        }
        
        stage('push') {
            steps {
                withCredentials([usernamePassword(credentialsId: '0c0af0dc-2acb-4f30-be59-5a66d40cb34f', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                    sh "docker tag tomcat-war:${BUILD_NUMBER} shashidhar09/myjenkinsprivate:${BUILD_NUMBER}"
                    sh "docker push shashidhar09/myjenkinsprivate:${BUILD_NUMBER}"
                }
            }
        }
        
        stage('deploy') {
            parallel {
                stage('deployQA') {
                    agent { label 'slave01' }
                    steps {
                        script {
                            withCredentials([usernamePassword(credentialsId: '0c0af0dc-2acb-4f30-be59-5a66d40cb34f', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                                sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                                sh "docker pull shashidhar09/myjenkinsprivate:${BUILD_NUMBER}"
                                sh 'docker rm -f tomcat-qa || true'
                                sh 'docker run -d -p 8080:8080 --name tomcat-qa shashidhar09/myjenkinsprivate:${BUILD_NUMBER}'
                            }
                        }
                    }
                }
                stage('deployProd') {
                    agent { label 'Slave2' }
                    steps {
                        script {
                            withCredentials([usernamePassword(credentialsId: '0c0af0dc-2acb-4f30-be59-5a66d40cb34f', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                                sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                                sh "docker pull shashidhar09/myjenkinsprivate:${BUILD_NUMBER}"
                                sh 'docker rm -f tomcat-prod || true'
                                sh 'docker run -d -p 8080:8080 --name tomcat-prod shashidhar09/myjenkinsprivate:${BUILD_NUMBER}'
                            }
                        }
                    }
                }
            }
        }
    }
}
