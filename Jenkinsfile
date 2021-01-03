pipeline {
    agent {
        docker { 
            image 'ubuntu' 
            args '--entrypoint='
        }

    }
    stages {
        stage('Test') {
            steps {
                sh 'uname -a'
            }
        }
    }
}
