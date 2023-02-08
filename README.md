My personal octoprint configuration, with the plugins I use baked in.

Example docker-compose snippet to run this:

```yaml
services:
  octoprint:
    image: ghcr.io/sgsunder/octoprint:latest
    volumes:
      - ./octoprint:/etc/octoprint:rw
      - octoprint-webcache:/etc/octoprint/generated:rw
    devices:
      - /dev/ttyACM0:/dev/ttyACM0
    ports:
      - 5000:5000
    logging:
      driver: local
      options:
        max-size: "1k"
        max-file: "3"
volumes:
  octoprint-webcache:
```
