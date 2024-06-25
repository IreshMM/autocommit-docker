pipelineJob("test-job") {
    description("This is a test job")
    definition {
        cpsScm {
            lightweight(true)
            scm {
                git {
                    remote {
                        url(repo_url)
                        credentials(INIT_REPO_CREDENTIALS_ID)
                    }
                    branch('master')
                }
            }
            scriptPath("Jenkinsfile")
        }
    }
}
