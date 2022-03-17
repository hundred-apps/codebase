FROM php:8.0-alpine as hundredapps

    ARG APP_TIMEZONE
    ARG APP_NAME
    ARG APP_MODE
    ARG APP_LOG_LEVEL
    ARG APP_HOST
    ARG APP_PORT

    # ARG GROUP=hundredapps #
    # ARG USER=${APP_NAME} #

    ENV TZ=${APP_TIMEZONE}
    ENV APP_NAME=${APP_NAME}
    ENV APP_MODE=${APP_MODE}
    ENV APP_LOG_LEVEL=${APP_LOG_LEVEL}
    ENV APP_HOST=${APP_HOST}
    ENV APP_PORT=${APP_PORT}

    WORKDIR /var/www/${APP_NAME}/
    COPY . .

    RUN apk update \
        && \
        php -r $(echo "cmVhZGZpbGUoJ2h0dHA6Ly9nZXRjb21wb3Nlci5vcmcvaW5zdGFsbGVyJyk7Cg==" | base64 -d) | php -- --install-dir=/usr/bin/ --filename=$(echo "Y29tcG9zZXIK" | base64 -d) \
        && \
        apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS $(echo "dHpkYXRhIG5vZGVqcyBucG0gY3VybC1kZXYgbGliemlwLWRldiB6aXAgdW56aXAK" | base64 -d) \
        freetype libjpeg-turbo libpng \
        freetype-dev libjpeg-turbo-dev libpng-dev \
        rabbitmq-c-dev librdkafka-dev \
        && \
        docker-php-ext-configure gd \
        --with-freetype=/usr/include/ \
        --with-jpeg=/usr/include/ \
        # --with-png=/usr/include/ \ #
        && \
        NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
        && \
        docker-php-ext-install -j${NPROC} zip gd curl bcmath pcntl sockets pdo pdo_mysql session tokenizer \
        && \
        printf "yes\n" | pecl install swoole && docker-php-ext-enable swoole && \
        printf "yes\n" | pecl install amqp && docker-php-ext-enable amqp && \
        printf "yes\n" | pecl install rdkafka && docker-php-ext-enable rdkafka && \
        printf "no\n" | pecl install redis && docker-php-ext-enable redis \
        && \
        apk del --no-cache freetype-dev libjpeg-turbo-dev libpng-dev && rm -rf /tmp/pear/ \
        && \
        if [ "${APP_MODE}" = "production" ]; then \
            cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" ; \
            echo "Set : php.ini-production" ; \
        else \
            cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" ; \
            echo "Set : php.ini-development" ; \
        fi \
        && \
        composer install --no-dev && npm install --production \
        && \
        chmod -R 777 bootstrap/cache storage;

        EXPOSE ${APP_PORT}

        ENTRYPOINT []
        CMD ["php", "artisan", "hundredapps:supervisor:start", "foreground"]