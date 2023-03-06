# imapsync-x-docker
This repository contains the Dockerfile and related code host the web-ui of [imapsync by Gilles Lamiral](https://imapsync.lamiral.info/).

Most of the code in this repository is directly taken from https://imapsync.lamiral.info, using the URLs provided with the [official docker image](https://hub.docker.com/r/gilleslamiral/imapsync).

## Running

### Docker Compose

```yaml
version: '3.6'

services:
  imapsync-x:
    image: ghcr.io/fyr77/imapsync-x-docker/imapsync-x:main
    container_name: imapsync-x
    ports:
      - 13531:80
    restart: unless-stopped
```
