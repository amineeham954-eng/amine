pipeline {
    agent any
    tools {
        maven "maven"  // Nom exact configuré dans Jenkins
    }
    environment {
        scannerHome = tool "SonarScanner"  // Nom défini dans Global Tool Configuration
    }
    stages {
        stage('Clone repo Git') {
            steps {
                sh "rm -rf *"
                sh "git clone https://github.com/amineeham954-eng/amine.git"
            }
        }
        stage('Build Maven') {
            steps {
                // Aller dans le dossier 'amine' (nom du repo cloné)
                sh "cd amine && mvn package -DskipTests"
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sq1') {  // Nom du serveur SonarQube dans Jenkins
                    sh """
                        cd amine && ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=sq1 \        // Clé du projet SonarQube
                        -Dsonar.projectName=projetjava \
                        -Dsonar.sources=src \
                        -Dsonar.java.binaries=target \
                        -Dsonar.host.url=http://sonarqube:9000 \
                        -Dsonar.login=${sq1}
                    """
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "cd amine && docker build -t amineeham954/projetjava:latest ."
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub',
                                                  usernameVariable: 'dockerHubUser',
                                                  passwordVariable: 'dockerHubPassword')]) {
                    sh "docker login -u ${dockerHubUser} -p ${dockerHubPassword}"
                    sh "docker push amineeham954/projetjava:latest"
                }
            }
        }
    }
}

