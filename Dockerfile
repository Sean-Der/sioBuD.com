FROM debian:stretch-slim

RUN apt-get update -q --fix-missing && \
    apt-get -y upgrade && \
    apt-get -y install sbcl nginx git curl supervisor

WORKDIR /etc/supervisor/conf.d
RUN echo "[program:sbcl]" >> sbcl.conf
RUN echo "command=/usr/bin/sbcl --eval '(ql:quickload \"siobud\")' --eval '(siobud::start-server)'" >> sbcl.conf

RUN echo "[program:nginx]" >> nginx.conf
RUN echo "command=/usr/sbin/nginx -g 'daemon off;'" >> nginx.conf

WORKDIR /root
RUN curl -O https://beta.quicklisp.org/quicklisp.lisp &&\
    sbcl --load quicklisp.lisp\
    --eval '(quicklisp-quickstart:install)' &&\
    echo '(load "/root/quicklisp/setup.lisp")' >> /root/.sbclrc &&\
    mkdir -p /root/quicklisp/local-projects/ &&\
    git clone https://github.com/Sean-Der/sioBuD.com

WORKDIR /root/quicklisp/local-projects
RUN ln -s /root/sioBuD.com/lisp /root/quicklisp/local-projects/siobud &&\
    sbcl --eval '(ql:quickload "siobud")'

RUN echo 'server {\n\
        listen 80 default_server;\n\
        listen [::]:80 default_server;\n\
        location / {\n\
                proxy_pass http://127.0.0.1:4242;\n\
                proxy_set_header Host $host;\n\
                proxy_set_header X-Real-IP $remote_addr;\n\
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n\
                proxy_http_version 1.1;\n\
        }\n\
        location /css { root /root/sioBuD.com/www/;  }\n\
        location /img { root /root/sioBuD.com/www/;  }\n\
        location /js { root /root/sioBuD.com/www/;  }\n\
        location /resume { root /root/sioBuD.com/www/;  }\n\
}\n'\
> /etc/nginx/sites-enabled/default

RUN sed -i "1s/.*/user root;/" /etc/nginx/nginx.conf

CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf -n
