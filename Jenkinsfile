pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                echo 'Building..'
                sh 'make clean'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'make deb-pkg'
            }
        }
    }
}
