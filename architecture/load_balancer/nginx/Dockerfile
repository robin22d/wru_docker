
FROM 		nginx

ADD		nginx.conf /etc/nginx/nginx.conf

RUN		apt -qq update && \
		apt -yq upgrade && \
		apt -yq install fail2ban

RUN		touch /etc/nginx/access.log

ADD		jail.local /etc/fail2ban/jail.local
ADD		nginx-http-auth.conf /etc/fail2ban/filter.d/nginx-http-auth.conf

ADD		run.sh /tmp/run.sh
RUN		chmod 755 /tmp/run.sh

WORKDIR		/tmp

CMD		./run.sh
