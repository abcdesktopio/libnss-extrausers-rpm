# libnss-extrausers-rpm

This Name Service Switch (NSS) module reads `/var/lib/extrausers/passwd`, `/var/lib/extrausers/shadow` and `/var/lib/extrausers/groups`, allowing to store system accounts and accounts copied from other systems in different files. 


# what is libnss-extrausers-rpm

This repo `libnss-extrausers-rpm` is a port of `libnss-extrausers` from debian to package management system that runs on Red Hat Enterprise Linux (RHEL)
This repository build the package `libnss-extrausers` for rpm on `rockylinux:8` and `rockylinux:9`

It creates release files for `amd64` and docker images for `amd64` and `arm64`.


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

- [libnss-extrausers-0.6-1.el8.x86_64.rpm](https://github.com/abcdesktopio/libnss-extrausers-rpm/releases/download/libnss-extrausers-0.6-1/libnss-extrausers-0.6-1.el8.x86_64.rpm)
- [libnss-extrausers-0.6-1.el9.x86_64.rpm](https://github.com/abcdesktopio/libnss-extrausers-rpm/releases/download/libnss-extrausers-0.6-1/libnss-extrausers-0.6-1.el9.x86_64.rpm)


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
- `ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:8`
- `ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:9`

## File location inside the container image 

rpm file is located inside the `/output` directory


- Dockerfile sample using `rockylinux:9`

```Dockerfile
FROM rockylinux:9
COPY --from=ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:9 /output/libnss-extrausers-0.6-1.el9.x86_64.rpm /tmp
RUN rpm -i /tmp/libnss-extrausers-0.6-1.el9.x86_64.rpm
```

