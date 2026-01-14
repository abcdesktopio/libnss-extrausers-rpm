# libnss-extrausers-rpm

This Name Service Switch (NSS) module reads `/var/lib/extrausers/passwd`, `/var/lib/extrausers/shadow` and `/var/lib/extrausers/groups`, allowing to store system accounts and accounts copied from other systems in different files. 


# what is libnss-extrausers-rpm

This repo `libnss-extrausers-rpm` is a port of `libnss-extrausers` from debian to package management system that runs on Red Hat Enterprise Linux (RHEL).

This repository build the `RPM` package of `libnss-extrausers` on 
- `rockylinux:8`
- `rockylinux:9`
- `almalinux:8`
- `almalinux:9`
- `almalinux:10`

It creates release files  for `amd64` and `arm64`.


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
- `ghcr.io/abcdesktopio/libnss-extrausers-rpm_almalinux:8`
- `ghcr.io/abcdesktopio/libnss-extrausers-rpm_almalinux:9`
- `ghcr.io/abcdesktopio/libnss-extrausers-rpm_almalinux:10`
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


# Test files using Dockerfile.testfile

To run the test
- clone this repo
- build the image using `Dockerfile.testfile` 


```
git clone https://github.com/abcdesktopio/libnss-extrausers-rpm.git
cd libnss-extrausers-rpm/testfile
docker build -t libnss-extrausers-rpm-test -f Dockerfile.testfile  .
```

You shoud read 


```
 => [internal] load build definition from Dockerfile.testfile                                                                                                                                        0.0s
 => => transferring dockerfile: 832B                                                                                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/rockylinux:9                                                                                                                                      0.0s
 => [internal] load metadata for ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:9                                                                                                             0.4s
 => [internal] load .dockerignore                                                                                                                                                                    0.0s
 => => transferring context: 2B                                                                                                                                                                      0.0s
 => CACHED [stage-1 1/9] FROM docker.io/library/rockylinux:9                                                                                                                                         0.0s
 => CACHED [image_source 1/1] FROM ghcr.io/abcdesktopio/libnss-extrausers-rpm_rockylinux:9@sha256:7ad469cadf99004549be4acee4415ad353f1e360bdadab911d3bedc7b36a1f4a                                   0.0s
 => [internal] load build context                                                                                                                                                                    0.0s
 => => transferring context: 144B                                                                                                                                                                    0.0s
 => [stage-1 2/9] RUN  dnf install -y diffutils                                                                                                                                                      7.8s
 => [stage-1 3/9] COPY --from=image_source /root/rpmbuild/RPMS/*/libnss-extrausers*.rpm /                                                                                                            0.1s 
 => [stage-1 4/9] RUN rpm -i /*.rpm                                                                                                                                                                  0.2s 
 => [stage-1 5/9] COPY passwd group shadow /var/lib/extrausers                                                                                                                                       0.0s 
 => [stage-1 6/9] COPY nsswitch.conf /etc/nsswitch.conf                                                                                                                                              0.0s 
 => [stage-1 7/9] COPY result.expected /                                                                                                                                                             0.0s 
 => [stage-1 8/9] RUN id fry > result.done                                                                                                                                                           0.2s 
 => [stage-1 9/9] RUN diff result.done /result.expected                                                                                                                                              0.2s
 => exporting to image                                                                                                                                                                               0.3s
 => => exporting layers                                                                                                                                                                              0.3s
 => => writing image sha256:cf7af669e50407782025a53cb67ef6f12e00f92b16603128569ba75418c98446                                                                                                         0.0s
 => => naming to docker.io/library/libnss-extrausers-rpm-test
```

The user `fry` is provisioned in the files `/var/lib/extrausers/passwd` and `/var/lib/extrausers/group`
 


