FROM php:7.3.6-fpm-alpine3.9

#instalacao do bash e mysql no momento da criacao
RUN apk add bash mysql-client
#instala para a aplicacao futura
RUN docker-php-ext-install pdo pdo_mysql

#instalacao do pacote para alterar o usermod
RUN apk add --no-cache shadow

#modifica o caminho de onde sera executado os comandos
WORKDIR /var/www
#remove a pasta html padrao da imagem alpine
RUN rm -rf /var/www/html

#instalacao do composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#executa a instalacao do laravel
# RUN composer install && \
#     cp .env.example .env && \
#     php artisan key:generate && \
#     php artisan config:cache

#copia todo conteudo da pasta local para o caminho var/www
#removido pois tera compartilhamento de volume
# COPY . /var/www

#atribui aos arquivos e pastas o proprietario www-data
RUN chown -R www-data:www-data /var/www

#cria um link simbolico para quando acessarem a pasta hmlt redirecione para public
RUN ln -s public html


#atribui grupo 1000 ao www-data
RUN usermod -u 1000 www-data
#muda o usuario padrao
USER www-data

EXPOSE 9000

ENTRYPOINT [ "php-fpm" ]
