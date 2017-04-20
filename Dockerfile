FROM golang:1.8.1-alpine

# Install OpenSSH server and Gitolite
# Unlock the automatically-created git user
RUN set -x \
 && apk add --no-cache \
    dumb-init \
    git \
 && mkdir /mirrors \
 && adduser -D -h /gitmirror -u 1001 git && chown -R git:1001 /mirrors

RUN go get -v github.com/dustin/gitmirror

# Volume used to store SSH host keys, generated on first run
VOLUME /mirrors

ADD ./run-gitmirror.sh /usr/local/bin/run-gitmirror.sh
USER git

ENV \
    HOOK_PORT="8124" \
    MIRROR_DIR="/mirrors"

# Entrypoint responsible for SSH host keys generation, and Gitolite data initialization
ENTRYPOINT ["dumb-init"]

# Default command is to run the SSH server
CMD ["run-gitmirror.sh"]
