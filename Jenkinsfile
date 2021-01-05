pipeline {
    agent any

    stages {
        stage('Vault lookup') {
            steps {
                sh 'vault token lookup'
            }
        }
    }
}
