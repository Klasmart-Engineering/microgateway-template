# Microgateway Template

A starter template to help teams create their own microgateway

## Useful docker commands

### Running locally

#### Validation

```sh
docker buildx build -t validate -f Dockerfile.validate . && \
    docker run -e REGION="global" -e ENVIRONMENT="landing-zone" validate
```

#### Run Gateway
```sh
docker buildx build -t gateway  . && \
    docker run -e FC_SETTINGS="/etc/krakend/config/settings/landing-zone/global" \
        -e FC_PARTIALS="/etc/krakend/config/partials" -e FC_TEMPLATES="/etc/krakend/config/templates" \
        -e FC_ENABLE=1 gateway
```