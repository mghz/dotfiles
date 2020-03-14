docker run --name cloudstack-mysql -e MYSQL_ROOT_PASSWORD=password -d docker.io/mysql:5.5
docker run --name cloudstack --link cloudstack-mysql:mysql -d -p 8000:8080 -p 8250:8250 docker.io/cloudstack/management_centos6
