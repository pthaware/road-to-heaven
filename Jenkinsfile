// pipeline → Defines the entire Jenkins Pipeline.
pipeline {

    // agent → Specifies where the pipeline should run.
    // any → Runs on any available Jenkins agent.
    agent any

    // stages → Groups all the stages of the pipeline.
    stages {

        // stage → Represents a logical phase of the pipeline.
        stage("Build") {

            // steps → Contains the commands to execute in this stage.
            steps {
                echo "Building project..."
            }
        }

        stage("Test") {
            steps {
                echo "Performing unit and integration testing..."
            }
        }
    }

    // post → Defines actions that run after the pipeline finishes.
    post {

        // always → Runs regardless of pipeline result (success, failure, aborted, etc.).
        always {
            echo "This step always executes, regardless of whether the pipeline succeeds or fails."
        }

        // success → Runs only if the pipeline completes successfully.
        success {
            echo "This step executes only if the pipeline succeeds."
        }

        // failure → Runs only if the pipeline fails.
        failure {
            echo "This step executes only if the pipeline fails."
        }
    }
}
