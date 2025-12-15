# libnss-extrausers-rpm
rpm package for nss-extrausers

# install

## rockylinux release 8

```
rpm -i https://github.com/abcdesktopio/libnss-extrausers-rpm/releases/download/libnss-extrausers-0.6-1/libnss-extrausers-0.6-1.el8.x86_64.rpm
```

## rockylinux release 9

```
rpm -i https://github.com/abcdesktopio/libnss-extrausers-rpm/releases/download/libnss-extrausers-0.6-1/libnss-extrausers-0.6-1.el9.x86_64.rpm
```
 
# download files

Download file from the release latest

[libnss-extrausers-0.6-1.el8.x86_64.rpm](https://github.com/abcdesktopio/libnss-extrausers-rpm/releases/download/libnss-extrausers-0.6-1/libnss-extrausers-0.6-1.el8.x86_64.rpm)
[libnss-extrausers-0.6-1.el9.x86_64.rpm](https://github.com/abcdesktopio/libnss-extrausers-rpm/releases/download/libnss-extrausers-0.6-1/libnss-extrausers-0.6-1.el9.x86_64.rpm)


# source

Get sources and apply Debian patches

- Download original Debian source
- Debian patchset

```
wget -O $SOURCES_DIR/libnss-extrausers_$VERSION.orig.tar.gz \  http://deb.debian.org/debian/pool/main/libn/libnss-extrausers/libnss-extrausers_0.6.orig.tar.gz && \
    wget -O $SOURCES_DIR/libnss-extrausers_$VERSION-$DEB_RELEASE.debian.tar.xz \
    http://deb.debian.org/debian/pool/main/libn/libnss-extrausers/libnss-extrausers_0.6-6.debian.tar.xz

```

# Dockerfile

This repo build for `amd64` and `arm64` the images 
- `ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:9`
- `ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:8`

## File location 

rpm file is located inside the `/output` directory

```Dockerfile
COPY --from=ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:9 /output/libnss-extrausers-0.6-1.el9.x86_64.rpm /
RUN rpm -i /libnss-extrausers*.rpm
```
