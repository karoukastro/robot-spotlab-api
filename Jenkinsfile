pipeline{
    agent {
        docker {
            image "qaninja/pyrobot2"
            args "-u root --privileges"
        }
    }

    stages{
        stage("Preparation"){
            steps{
                input message: "Continuar?", ok: "Sim"
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
