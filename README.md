# libnss-extrausers-rpm
rpm package for nss-extrausers


# Source

Get sources and apply Debian patches

- Download original Debian source
- Debian patchset

```
wget -O $SOURCES_DIR/libnss-extrausers_$VERSION.orig.tar.gz \  http://deb.debian.org/debian/pool/main/libn/libnss-extrausers/libnss-extrausers_0.6.orig.tar.gz && \
    wget -O $SOURCES_DIR/libnss-extrausers_$VERSION-$DEB_RELEASE.debian.tar.xz \
    http://deb.debian.org/debian/pool/main/libn/libnss-extrausers/libnss-extrausers_0.6-6.debian.tar.xz

```

# Dockerfile

This repo build this images `ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:9` and `ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:8` for `amd64` and `arm64`

## File location 

```Dockerfile
COPY --from=ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:9 /root/rpmbuild/RPMS/*/libnss-extrausers*.rpm /
RUN rpm -i /libnss-extrausers*.rpm
```
