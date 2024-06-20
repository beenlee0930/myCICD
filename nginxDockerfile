#nginx

FROM ubuntu:20.04

RUN apt-get update && apt-get install -y nginx
RUN mv /etc/localtime /etc/localtime_org \
       && ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime

COPY default /etc/nginx/sites-available/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
