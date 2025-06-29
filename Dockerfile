FROM centos:8
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y install java
CMD /bin/bash
RUN yum install -y httpd
RUN yum install -y zip
RUN yum install -y unzip
ADD site-template.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip -q site-template.zip
RUN cp -rvf */* .
RUN rm -rf site-template.zip */
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80 22