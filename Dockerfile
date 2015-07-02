FROM leonlei1983/ubuntu

ENV USERID 1000
RUN apt-get update && \
	apt-get install -y apache2 && \
	apt-get autoclean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /root

ADD gitweb.conf /etc/apache2/conf-available
ADD launch.sh /usr/local/bin

RUN git clone git://git.kernel.org/pub/scm/git/git.git && \
	cd git && \
	make GITWEB_PROJECTROOT="/opt/git" prefix=/usr gitweb && \
	cp -Rf gitweb /var/www/ && \
	ln -s ../conf-available/gitweb.conf /etc/apache2/conf-enabled/gitweb.conf && \
	chmod +x /usr/local/bin/launch.sh && \
	a2enmod cgi

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/local/bin/launch.sh"]
