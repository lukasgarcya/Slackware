FROM vbatts/slackware-base

RUN echo "ftp://ftp.osuosl.org/.2/slackware/slackware64-14.2/" > /etc/slackpkg/mirrors
RUN slackpkg -batch=on -default_answer=yes update && slackpkg -batch=on -default_answer=yes upgrade-all
# Upgrading CA-certificates
RUN slackpkg -batch=on -default_answer=yes install ca-certificates && ( cd /etc/ssl/certs; grep -v '^#' /etc/ca-certificates.conf | while read CERT; do ln -fsv /usr/share/ca-certificates/$CERT `basename ${CERT/.crt/.pem}`; ln -fsv /usr/share/ca-certificates/$CERT `openssl x509 -hash -noout -in /usr/share/ca-certificates/$CERT`.0; done )
RUN slackpkg -batch=on -default_answer=yes install a/* ap/* d/* e/* kde/* l/* n/* t/* tcl/* x/* xap/* y/*
