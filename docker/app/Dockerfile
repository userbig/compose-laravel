FROM php:7.4.4-fpm-alpine

LABEL Description="Application container"

ENV PS1='\[\033[1;32m\]🐳  \[\033[1;36m\][\u@\h] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'

# persistent / runtime deps
ENV PHPIZE_DEPS \
    autoconf \
    cmake \
    file \
    g++ \
    gcc \
    libc-dev \
    pcre-dev \
    make \
    git \
    pkgconf \
    re2c \
    # for GD
    freetype-dev \
    libpng-dev  \
    libjpeg-turbo-dev \
    libxslt-dev

RUN apk add \
    git \
    curl \
    mysql-client \
    bash nano \
	# for intl extension
	icu-dev \
	# for postgres
	postgresql-dev \
	# for soap
	libxml2-dev \
	# for GD
	freetype \
	libpng \
	libjpeg-turbo \
	# for bz2 extension
	bzip2-dev \
	gmp-dev \

#	zlib
	libzip-dev \
	# for intl extension
	libintl gettext-dev libxslt \
	busybox-suid


RUN set -xe \
	&& apk add --no-cache --virtual .build-deps \
	    $PHPIZE_DEPS \
	&& docker-php-ext-configure gd \
	    --with-freetype \
	    --with-jpeg \
	&& docker-php-ext-configure bcmath --enable-bcmath \
	&& docker-php-ext-configure intl --enable-intl \
	&& docker-php-ext-configure pcntl --enable-pcntl \
	&& docker-php-ext-configure pdo_mysql --with-pdo-mysql \
	&& docker-php-ext-configure pdo_mysql \
	&& docker-php-ext-configure gmp \
	# && docker-php-ext-configure pdo_pgsql --with-pgsql \
	&& docker-php-ext-configure opcache --enable-opcache \
	&& docker-php-ext-install -j$(nproc) \
	    gd \
	    bcmath \
	    intl \
	    pcntl \
	    mysqli \
	    pdo_mysql \
	    pdo_pgsql \
	    soap \
	    iconv \
	    bz2 \
	    calendar \
	    exif \
	    gettext \
	    shmop \
	    sockets \
	    sysvmsg \
	    sysvsem \
	    sysvshm \
	    xsl \
	    zip \
	    opcache \
	    gmp


ENV COMPOSER_ALLOW_SUPERUSER 1

ARG USER_ID=1000
ARG GROUP_ID=1000


RUN set -x \
	&& mkdir -p /app

#COPY ./src /app

RUN set -x ; \
      addgroup -g ${GROUP_ID} -S group ; \
      adduser -u ${USER_ID}  -D -S -G group -s /bin/bash user; \
      chown -R ${USER_ID}:${GROUP_ID} /app;




RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


COPY ./start.sh /usr/local/bin/start

#RUN chown -R www-data:www-data /app \
#    && chmod u+x /usr/local/bin/start

WORKDIR /app

USER ${USER_ID}



ENTRYPOINT ["/bin/bash", "/usr/local/bin/start"]

