pipelineJob("test-job") {
    description("This is a test job")
    definition {
        cpsScm {
            lightweight(true)
            scm {
                git("ssh://nodemon@nodemon:target.git")
            }
            scriptPath("Jenkinsfile")
        }
    }
}