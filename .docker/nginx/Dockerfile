FROM nginx:1.15.0-alpine

#remove a configuracao padrao do ngnix
RUN rm /etc/nginx/conf.d/default.conf

COPY ./nginx.conf /etc/nginx/conf.d
