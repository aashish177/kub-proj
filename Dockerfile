FROM centos:8

# Fix CentOS 8 repo issue
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' CentOS-*

# Install required packages
RUN yum -y install java httpd zip unzip && \
    yum clean all

# Download working website zip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page295/solar.zip /var/www/html/

# Set working directory
WORKDIR /var/www/html/

# Unzip the downloaded zip file
RUN unzip -q solar.zip && \
    rm -f solar.zip

# Start Apache in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose necessary ports
EXPOSE 80 22