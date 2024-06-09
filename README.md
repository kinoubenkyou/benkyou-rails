# benkyou-rails

An app for learning rails

## development

### dependencies

- [docker](https://www.docker.com/)

### start app

```shell
docker compose up -d
```

### start shell

```shell
docker exec -it benkyou-rails-app-1 bash
```

### stop app

```shell
docker compose down
```

### rebuild image (to add/update/remove packages, etc.)

```shell
docker compose down
docker image rm benkyou-rails-app
docker system prune -af
docker compose build
```
