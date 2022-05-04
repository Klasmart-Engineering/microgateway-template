# Microgateway Template

A starter template to help teams create their own microgateway

## Important notes

The [API Management team](https://calmisland.atlassian.net/wiki/spaces/AM/overview?homepageId=2619113904) have done their best to expose a number of features to support teams in configuring and managing their gateways. This includes having syncing mechanisms that will automatically raise PRs whenever configuration _(centrally managed)_ or plugins are updated.

Please endeavor to review and merge these PRs in as quickly as possible as it will allow us to keep gateway deployments across the company in sync.

As some of the configuration is centrally managed, the team has a number of **protected** files within the file tree _(that will be automatically synced with your repository)_. These protected files will automatically be overwritten in your repository, so please avoid editting them.

## Helm

The team has provided a base `values.yaml` file for you to customize specific to your microgateway. Please customize it
as you need. You might also need to create mutliple versions of the file for different environments. If you have any
requirements which the current template doesn't support, please feed this back to the API management team.

### Protected files

| Path                                               | Description                                                                                          |
| -------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| `config/settings/shared/common.json`               | this is used to hold central configuration that should be shared across all regions and environments |
| `config/settings/{environment}/{region}/auth.json` | contains configuration related to our Azure B2C token validation                                     |
| `config/templates/jwks-validation-plugin.json`     | contain a template that can be used to easily add Azure B2C validation to your endpoint              |

### Special Files/Directories

| Path                       | Description                                                                                                                                                                                                             |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `config/settings/shared/*` | we will copy the contents of everything within this directory into the build, so regardless of the `REGION` or `ENVIRONMENT`, every file in this directory will be accessible by the final `krakend.json` configuration |


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
