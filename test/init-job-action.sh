#!/bin/bash
cat /home/nodemon/target/Jenkinsfile | jenkins_cli declarative-linter && jenkins_cli build init-job -s -v