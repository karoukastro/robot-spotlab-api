pipeline{
    agent {
        docker {
            image "qaninja/pyrobot2"
        }
    }

    stages{
        stage("Preparation"){
            steps{
                sh "python3 -m venv env"
                sh "source ./env/bin/activate"
                sh "pip install -r requirements.txt --user"
            }
        }

        stage ("Tests"){
            steps{
                sh "robot -d ./logs -i smoke tests"
            }
        }
    }
}
