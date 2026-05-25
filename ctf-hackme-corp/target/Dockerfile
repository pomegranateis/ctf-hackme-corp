FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR=/var/log/apache2

RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    mysql-server \
    openssh-server \
    vsftpd \
    supervisor \
    python3 \
    python3-pip \
    curl \
    wget \
    net-tools \
    iputils-ping \
    libimage-exiftool-perl \
    gcc \
    sudo \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Apache — enable headers mod
RUN a2enmod headers rewrite

# Apache config — allow .htaccess and headers
RUN echo "ServerTokens Full\nServerSignature On" >> /etc/apache2/conf-available/security.conf && \
    a2enconf security

# Copy web application files
COPY web/ /var/www/html/
RUN mkdir -p /var/www/html/uploads && \
    chown -R www-data:www-data /var/www/html/ && \
    chmod 755 /var/www/html/ && \
    chmod 777 /var/www/html/uploads/

# SSH configuration
RUN mkdir -p /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Create student user with weak password (intentional for CTF)
RUN useradd -m -s /bin/bash student && \
    echo "student:password123" | chpasswd && \
    echo "root:toor" | chpasswd

# vsftpd configuration — anonymous login enabled (intentional for CTF)
RUN echo "anonymous_enable=YES\nlocal_enable=NO\nwrite_enable=NO\nanon_root=/srv/ftp\npasv_enable=YES\npasv_min_port=30000\npasv_max_port=30009" > /etc/vsftpd.conf && \
    mkdir -p /srv/ftp/pub && \
    chown -R ftp:ftp /srv/ftp && mkdir -p /var/run/vsftpd/empty

# Supervisor config to start all services
COPY supervisord.conf /etc/supervisor/conf.d/ctf.conf

# Copy and set executable the setup script
COPY setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 21 22 80 3306

CMD ["/setup.sh"]
