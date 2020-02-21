pipeline{
    agent {
        docker {
            image "qaninja/pyrobot2"
        }
    }

    stages{
        stage("Preparation"){
            steps{
                sh "pip3 install -r requirements.txt --user"
            }
        }

        stage ("Tests"){
            steps{
                sh "robot -d ./logs -i smoke tests"
            }
        }
    }
}
