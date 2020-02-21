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
                sh "python -m pip install -r requirements.txt"
            }
        }

        stage ("Tests"){
            steps{
                sh "robot -d ./logs -i smoke tests"
            }
        }
    }
}
