 pipeline {
    agent any
 
    environment {
        PROJECT_NAME      = 'mycicd'                              // 프로젝트 명
        GIT_URL           = 'https://github.com/beenlee0930/myCICD.git' // git URL      
        DOCKER_CREDENTIAL = 'docker-id'                             // docker Credntial ID
        DOCKER_IMAGE_TOMCAT = ''
        DOCKER_IMAGE_NGINX = ''
        DOCKER_USERNAME   = ''
        DOCKER_PASSWORD   = ''

    }
    
    tools {
        nodejs 'NodeJS'
    }
 
    stages {
        stage('Pre build') {
            steps {
                sh "node --version"
                sh "git --version"
                git branch: 'main', credentialsId: 'github-id', url: "${GIT_URL}"
            }
        }
        
        stage('Build Tomcat image') {
            steps {
                echo 'Build Tomcat Docker'
                sh "docker -v"
                
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIAL}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        DOCKER_USERNAME = "${DOCKER_USERNAME}"
                        DOCKER_PASSWORD = "${DOCKER_PASSWORD}"
                        DOCKER_IMAGE_TOMCAT = "${DOCKER_USERNAME}/${PROJECT_NAME}-tomcat:latest"
                    }
                    
                    sh "docker build --platform linux/amd64 -f tomcatDockerfile -t ${DOCKER_IMAGE_TOMCAT} ."
                    sh "docker inspect ${DOCKER_IMAGE_TOMCAT}"
                }
            }
        }
        
        stage('Build Nginx image') {
            steps {
                echo 'Build Nginx Docker'
                sh "docker -v"
                
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIAL}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        DOCKER_USERNAME = "${DOCKER_USERNAME}"
                        DOCKER_PASSWORD = "${DOCKER_PASSWORD}"
                        DOCKER_IMAGE_NGINX = "${DOCKER_USERNAME}/${PROJECT_NAME}-nginx:latest"
                    }
                    
                    sh "docker build --platform linux/amd64 -f nginxDockerfile -t ${DOCKER_IMAGE_NGINX} ."
                    sh "docker inspect ${DOCKER_IMAGE_NGINX}"
                }
            }
        }
        
        
        stage('Push Docker images') {
            steps {
                echo 'Push Docker images'
                script {
                    try {
                        withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIAL}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                            sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                            sh "docker push ${DOCKER_IMAGE_TOMCAT}"
                            sh "docker push ${DOCKER_IMAGE_NGINX}"
                        }
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error "Failed to push Docker images: ${e.message}"
                    }
                }
            }
        }
    }
}
