# dsvpn-docker

This repository is used to build docker images for [dsvpn](https://github.com/jedisct1/dsvpn).

View all available image tags, see https://hub.docker.com/r/cofyc/dsvpn/tags.

## Example

```
docker run --name dsvpn.service \
  --network host \
  --privileged \
  -v /etc/dsvpn.key:/etc/dsvpn.key \
  cofyc/dsvpn:latest \
  server /etc/dsvpn.key auto 443
```

`/etc/dsvpn.key` is your VPN secure key.
