pipeline {
    agent any
    tools {
        maven "maven"  // Nom exact configuré dans Jenkins
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
