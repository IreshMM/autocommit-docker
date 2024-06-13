FROM bitnami/git

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y inotify-tools rsync
COPY autocommit.sh /autocommit.sh
ENTRYPOINT [ "/autocommit.sh" ]