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
