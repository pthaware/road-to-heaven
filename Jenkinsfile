@Library("Shared") _

pipeline {
    agent {
        label "piyush"
    }

    stages {

        stage("Fetch the code from github") {
            steps {
                script {
                    clone(
                        "https://github.com/ankugomkar13/road-to-heaven.git",
                        "Nodejs"
                    )
                }
            }
        }

        stage("Build") {
            steps {
                script {
                    docker_build("notes-app", "latest")
                }
            }
        }

        stage("Push image to Docker Hub new ") {
            steps {
                script {
                    docker_push("notes-app", "latest", "ankita133")
                }
            }
        }

        stage("Deploy") {
            steps {
                echo "Deploy the code using docker only"

                sh '''
                    docker rm -f notes-app || true
                    docker run -d \
                        --name notes-app \
                        -p 3001:3001 \
                        notes-app:latest
                '''
            }
        }
    }
}
