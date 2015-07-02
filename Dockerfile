FROM leonlei1983/ubuntu

RUN apt-get update && \
	apt-get install -y apache2 && \
	apt-get autoclean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /root

ADD gitweb.conf /etc/apache2/conf-available

RUN git clone git://git.kernel.org/pub/scm/git/git.git && \
	cd git && \
	make GITWEB_PROJECTROOT="/opt/git" prefix=/usr gitweb && \
	cp -Rf gitweb /var/www/ && \
	ln -s ../conf-available/gitweb.conf /etc/apache2/conf-enabled/gitweb.conf && \
	a2enmod cgi

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
