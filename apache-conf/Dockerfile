FROM leonlei1983/ubuntu

RUN apt-get update && \
	apt-get install -y apache2 apache2-utils && \
	apt-get autoclean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /root

ADD apache-conf/gitweb.conf /etc/apache2/conf-available/

RUN git clone git://git.kernel.org/pub/scm/git/git.git && \
	cd git && \
	make GITWEB_PROJECTROOT="/opt/git" prefix=/usr gitweb && \
	cp -Rf gitweb /var/www/ && \
	ln -s ../conf-available/gitweb.conf /etc/apache2/conf-enabled/gitweb.conf && \
	sed -i 's/font-size: small/font-size: large/g' /var/www/gitweb/static/gitweb.css && \
	sed -i 's/home_link_str = "projects"/home_link_str = "git"/g' /var/www/gitweb/gitweb.cgi && \
	a2enmod cgi

EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
