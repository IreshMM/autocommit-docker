#!/bin/bash
cat /home/nodemon/target/Jenkinsfile | jenkins_cli declarative-linter && jenkins_cli build test-job -s -v