FROM debian:sid-slim

RUN apt-get update -q --fix-missing && \
    apt-get -y upgrade && \
    apt-get -y install nginx git

RUN echo "command=/usr/sbin/nginx -g 'daemon off;'" >> nginx.conf

WORKDIR /root
RUN git clone https://github.com/Sean-Der/sioBuD.com
RUN echo 'server {\n\
        listen 80 default_server;\n\
        listen [::]:80 default_server;\n\
        location / { root /root/sioBuD.com/www/;  }\n\
}\n'\
> /etc/nginx/sites-enabled/default

RUN sed -i "1s/.*/user root;/" /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
