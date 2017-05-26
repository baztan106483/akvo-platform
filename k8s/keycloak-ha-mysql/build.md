
## Building Keycloak from sources

### Why?

Keycloak team does not patch the community version. In order to benefit from
_backported_ changes we need to build the code ourselves.

> The RH-SSO product derives from a specific version of the Keycloak
> community and is maintained, patched, and supported by Red Hat
> commercially for as long as the terms of your support contract.
> The Keycloak community project, on the other hand, is never patched.

More info at: http://www.keycloak.org/support.html

### Dependencies

* Git
* JDK 8
* Maven 3

### Clone repo

    git clone https://github.com/keycloak/keycloak.git

### Checkout tag

    cd keycloak
    git checkout 2.5.6.Final # Change the tag to the latest release

### Build distribution

We're skipping the tests as we expect the Keycloak team already
executed the tests before tagging the release (also to save time,
as the full test suite takes >30 minutes)

    mvn clean package -DskipTests -Pdistribution

You should have now a file named `keycloak-VERSION-tar.gz` under
`distribution/server-dist/target` folder, e.g.

    distribution/server-dist/target/keycloak-2.5.6.Final.tar.gz
