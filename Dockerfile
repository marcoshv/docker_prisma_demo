# Usamos una imagen base de nginx
FROM ubuntu:18.04

#Install NGINX
RUN apt update -y && apt install -y curl -qqy git wget netcat gcc build-essential procps iputils-ping dnsutils nginx

# Copiamos el archivo index.html al directorio de nginx
COPY ./index.html /var/www/html/index.html
RUN /etc/init.d/nginx start

# Exponemos el puerto 80
EXPOSE 80

#Malware-and-Crypto-Miner
RUN wget -q https://github.com/xmrig/xmrig/releases/download/v6.19.2/xmrig-6.19.2-linux-x64.tar.gz && tar -xf xmrig-6.19.2-linux-x64.tar.gz

#Netcat-Port-Scan
RUN netcat -z -v 127.0.0.1 1-1000

#start-nginx
ENTRYPOINT ["nginx","-g","daemon off;"]