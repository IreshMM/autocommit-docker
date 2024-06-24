# Grab Jenkins CLI
FROM jenkins/jenkins:lts-jdk17 as jenkins_build
RUN unzip /usr/share/jenkins/jenkins.war  WEB-INF/lib/cli-2.452.2.jar -d /tmp

# Main image
FROM ubuntu:22.04

# Set debian frontend
ENV DEBIAN_FRONTEND=noninteractive

# Install nodejs and nodemon
RUN apt-get update && apt-get install -y curl locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs
RUN npm install -g nodemon

# Install neccessary packages
RUN apt-get install -y rsync openjdk-17-jre-headless git openssh-server

# Install Jenkins CLI
COPY --from=jenkins_build /tmp/WEB-INF/lib/cli-2.452.2.jar /usr/share/jenkins/ref/jenkins-cli.jar

# Copy scripts
ENV SCRIPTS_DIR /usr/local/scripts
COPY scripts ${SCRIPTS_DIR}

# Configure user and permissions
RUN useradd -m -s /usr/bin/bash -u 1000 nodemon
RUN chown -R nodemon:nodemon ${SCRIPTS_DIR}
RUN mkdir -p /home/nodemon/source /home/nodemon/target
RUN chown -R nodemon:nodemon /home/nodemon
USER nodemon
WORKDIR /home/nodemon

# Config SSHD
RUN mkdir -p /home/nodemon/.sshd
COPY config/sshd_config /home/nodemon/.sshd/sshd_config

# Set entrypoint
ENTRYPOINT ["/usr/local/scripts/entrypoint.sh"]