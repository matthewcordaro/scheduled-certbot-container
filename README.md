# Scheduled Certbot Container

While [certbot](https://certbot.eff.org/) has [containers](https://hub.docker.com/r/certbot), their offerings don't have an update scheduler build in, so they only run once leaving you to spin them up every day.  With this container, that feature is built in!

## Setup

1. Clone Repository.

2. Modify the `config` file: Add your IAM keys, domain, and email address.

3. Create volume `docker volume create certs` to house the certificate files.

4. Build and deploy `docker compose up --build -d`.

5. Take a look at the docker logs to make sure that everything went smoohely

    if so, set `STAGING=false` in the config file and rerun your container.

You should now see your production ready cert files located at `/DOMAIN/` in the `certs` docker volume.

## Cert Location

The Certs are saved into a `certs` volume in the directory that matches the domain in the configuration.  _Note: Currently supports Route53 Only._

---

## Further Modifications

### Update Cadence

Edit the `crontab` file appropriately.  Currently 8AM every day.  [crontab guru](https://crontab.guru)

### Timezone

Edit the `compose.yaml` and modify the time zone abbreviations in the `TZ` variable.

### Cert Save Location

While the the Certs are located in the volume defined in `compose.yaml`, they are also stored in the container's ephemeral storage too as specified by `certbot`.  See their documentation.  You can edit the volume name in `compose.yaml`, just make sure to edit both locations in the file:

```yaml
...
volumes:
    - VOLUME_NAME:/certs
environment:
...
```

AND

```yaml
...
volumes:
  VOLUME_NAME:
    external: true
...
```
