#!/bin/sh

apt-get install proftpd-* ;
ln -s /etc/proftpd/proftpd.conf /etc/proftpd/proftpd.conf.backup ;

sed -i '149,173 s/^#//g' /etc/proftpd/proftpd.conf ;
sed -i '186,188 s/^#//g' /etc/proftpd/proftpd.conf ;
sed -i '143 s/^#//g' /etc/proftpd/proftpd.conf ;
sed -i '9,12 s/^#//g' /etc/proftpd/tls.conf ;
sed -i '45 s/^#//g' /etc/proftpd/tls.conf ;
sed -i '45 s/on/off/g' /etc/proftpd/tls.conf ;
sed -i '49 s/^#//g' /etc/proftpd/tls.conf ;
sed -i '49 s/on/off/g' /etc/proftpd/tls.conf ;
echo 'Include /etc/proftpd/tls.conf' >> /etc/proftpd/tls.conf ;
sed -i '27,28 s/^#//g' /etc/proftpd/tls.conf ;

openssl genrsa -out /etc/ssl/private/proftpd.key 1024 ;

openssl req -new -x509 -days -365 -key /etc/ssl/private/proftpd.key -out /etc/ssl/certs/proftpd.crt ;

service proftpd restart
