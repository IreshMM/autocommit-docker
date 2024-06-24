pipelineJob('init-job') {
    description('The root initialization job')
    definition {
        cpsScm {
            lightweight(true)
            scm {
                git {
                    remote {
                        url(INIT_REPO_URL)
                        credentials(INIT_REPO_CREDENTIALS_ID)
                    }
                    branch('master')
                }
            }
            scriptPath('Jenkinsfile')
        }
    }
}