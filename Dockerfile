FROM rhscl/httpd-24-rhel7

USER root

RUN yum -y remove httpd24-httpd-2.4.27-8.el7.1 && \
    yum-config-manager --enable rhel-7-server-optional-rpms && \
    yum -y install mod_auth_openidc && \
    yum -y install mod_ssl && \
    yum -y install mod_ldap && \
    rm -f /etc/httpd/conf/httpd.conf && \
    yum clean all -y

RUN rm -f /etc/httpd/conf/httpd.conf

COPY flask.conf /etc/httpd/conf.d/flask.conf

COPY ssl.conf /etc/httpd/conf.d/ssl.conf

COPY httpd.conf /etc/httpd/conf/httpd.conf

RUN chmod -R 777 /etc/httpd

RUN chmod -R 777 /run/httpd

USER 1001
