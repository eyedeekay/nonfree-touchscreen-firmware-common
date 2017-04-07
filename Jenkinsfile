pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                echo 'Cleaning....'
                sh 'make debclean'
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
