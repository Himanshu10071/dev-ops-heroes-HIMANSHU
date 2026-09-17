$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host 'Creating three bridge networks...'
docker network create homework-frontend-net 2>$null
docker network create homework-database-net 2>$null
docker network create homework-monitoring-net 2>$null

Write-Host 'Starting frontend, backend, and database containers...'
docker rm -f homework-frontend homework-backend homework-db 2>$null
docker run -d --name homework-frontend --network homework-frontend-net nginx:alpine
docker run -d --name homework-backend --network homework-frontend-net alpine:3.20 sleep 1d
docker network connect homework-database-net homework-backend
docker run -d --name homework-db --network homework-database-net -e MYSQL_ROOT_PASSWORD=homework-root -e MYSQL_DATABASE=homework mysql:8.4

Write-Host 'Frontend to backend name-resolution check:'
docker exec homework-frontend getent hosts homework-backend
Write-Host 'Backend to database name-resolution check:'
docker exec homework-backend getent hosts homework-db
Write-Host 'Backend network membership:'
docker inspect homework-backend --format '{{range $name, $network := .NetworkSettings.Networks}}{{$name}} {{end}}'

Write-Host 'Starting Apache with host networking...'
docker rm -f homework-apache 2>$null
docker run -d --name homework-apache --network host httpd:2.4-alpine

Write-Host 'Starting bind-mount Nginx...'
docker rm -f homework-bind-nginx 2>$null
docker run -d --name homework-bind-nginx -p 8090:80 -v "${root}\bind-mount:/usr/share/nginx/html:ro" nginx:alpine

Write-Host 'Creating overlay network (single-node Swarm)...'
docker swarm init 2>$null
docker network create --driver overlay homework-overlay 2>$null

Write-Host 'Running container summary:'
docker ps --filter 'name=homework-' --format 'table {{.Names}}\t{{.Status}}\t{{.Networks}}\t{{.Ports}}'

Write-Host 'Bind-mount initial response:'
(Invoke-WebRequest -UseBasicParsing http://localhost:8090).Content
