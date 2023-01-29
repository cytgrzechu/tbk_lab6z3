# Budujemy obrazy dla flask i expressJs
docker build -t flask-service flask
docker build -t expressjs-service express

# Uruchamiamy bazę PostgreSql
docker container run -d --name postgres --label traefik.port=5432 `
--mount type=bind,source="$(Get-Location)"/db,target=/docker-entrypoint-initdb.d `
--mount source=pg-data,target=/var/lib/postgresql/data `
-e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=mysecretpassword -e POSTGRES_DB=db postgres:11.5-alpine

# Backend z expressJs
docker container run --rm -d --name express `
--label traefik.enable=true `
--label traefik.port=3000 `
--label traefik.priority=1 `
--label traefik.http.routers.express.rule="Host(\`"test.com\`")" `
expressjs-service

# Backend z flask
docker container run --rm -d --name flask `
--label traefik.enable=true `
--label traefik.port=5000 `
--label traefik.priority=10 `
--label traefik.http.routers.flask.rule="Host(\`"test.com\`") && PathPrefix(\`"/cars\`")" `
flask-service

# Router brzegowy traefic
docker run -d --name traefik `
-p 8080:8080 -p 80:80 `
-v /var/run/docker.sock:/var/run/docker.sock traefik:v2.0 `
--api.insecure=true `
--providers.docker
