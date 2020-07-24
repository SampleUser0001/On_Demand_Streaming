FROM nginx:latest

COPY html /usr/share/nginx/html

RUN  mkdir /usr/share/nginx/html/movie && chown nobody /usr/share/nginx/html/movie
COPY movie /usr/share/nginx/html/movie
