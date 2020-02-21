pipeline{
    agent {
        docker {
            image "qaninja/pyrobot2"
            args "-u root --privileged"
        }
    }

    stages{
        stage("Preparation"){
            steps{
                sh "pip install -r requirements.txt"
            }
        }

        stage ("Tests"){
            steps{
                sh "robot -d ./logs -i smoke tests"
            }
        }
    }
}
