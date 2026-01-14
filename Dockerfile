# -----------------------------------------------------------------------------
# Build environment for libnss-extrausers on Rocky Linux 9
# This container:
#   - installs build tools
#   - downloads Debian sources
#   - adds an autotools build system (configure.ac + Makefile.am)
#   - runs autoreconf to generate configure
#   - builds the library via rpmbuild
# -----------------------------------------------------------------------------

# default TAG is dev
ARG BASE_RELEASE=9
ARG BASE_IMAGE=rockylinux

FROM ${BASE_IMAGE}:${BASE_RELEASE}


# Environment variables
ENV SPEC_DIR=/root/rpmbuild/SPECS
ENV SOURCES_DIR=/root/rpmbuild/SOURCES
ENV VERSION=0.6
ENV DEB_RELEASE=6

# -----------------------------------------------------------------------------
# Install dependencies
# -----------------------------------------------------------------------------
RUN dnf install -y \
        rpm-build \
        gcc \
        make \
        autoconf \
        automake \
        libtool \
        gettext \
        tar \
        xz \
        wget \
        which \
        findutils \
        git \
        vim \
    && dnf clean all

# -----------------------------------------------------------------------------
# Prepare the rpmbuild structure
# -----------------------------------------------------------------------------
RUN mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

WORKDIR /root

# -----------------------------------------------------------------------------
# Download original Debian source + Debian patchset
# -----------------------------------------------------------------------------
RUN wget -O $SOURCES_DIR/libnss-extrausers_$VERSION.orig.tar.gz \
    http://deb.debian.org/debian/pool/main/libn/libnss-extrausers/libnss-extrausers_$VERSION.orig.tar.gz && \
    wget -O $SOURCES_DIR/libnss-extrausers_$VERSION-$DEB_RELEASE.debian.tar.xz \
    http://deb.debian.org/debian/pool/main/libn/libnss-extrausers/libnss-extrausers_$VERSION-$DEB_RELEASE.debian.tar.xz


# -----------------------------------------------------------------------------
# Add autotools build system inside the source tree.
# We extract the source into /tmp, patch it, add configure.ac + Makefile.am,
# repack it into a new tarball for rpmbuild.
# -----------------------------------------------------------------------------
RUN mkdir /tmp/src
RUN cd /tmp/src && tar -xf /root/rpmbuild/SOURCES/libnss-extrausers_$VERSION.orig.tar.gz
RUN cd /tmp/src/libnss-extrausers-$VERSION && tar -xf /root/rpmbuild/SOURCES/libnss-extrausers_$VERSION-$DEB_RELEASE.debian.tar.xz

# -----------------------------------------------------------------------------
# Inject autotools build files
# -----------------------------------------------------------------------------
COPY configure.ac /tmp/src/libnss-extrausers-$VERSION/
COPY Makefile.am /tmp/src/libnss-extrausers-$VERSION/
COPY src-Makefile.am /tmp/src/libnss-extrausers-$VERSION/src/Makefile.am
COPY Makefile /Makefile 

# -----------------------------------------------------------------------------
# Generate configure script using autoreconf
# -----------------------------------------------------------------------------
RUN cd /tmp/src/libnss-extrausers-$VERSION && autoreconf -fi

# -----------------------------------------------------------------------------
# Repack sources including autotools build system
# -----------------------------------------------------------------------------
RUN cd /tmp/src && \
    tar -czf /root/rpmbuild/SOURCES/libnss-extrausers-$VERSION-autotools.tar.gz libnss-extrausers-$VERSION

# -----------------------------------------------------------------------------
# Copy final SPEC file
# -----------------------------------------------------------------------------
COPY libnss-extrausers.spec /root/rpmbuild/SPECS/

# -----------------------------------------------------------------------------
# Build RPM
# -----------------------------------------------------------------------------
RUN rpmbuild -ba --define "debug_package %nil" /root/rpmbuild/SPECS/libnss-extrausers.spec

RUN mkdir -p /output && cp /root/rpmbuild/RPMS/*/libnss-extrausers-*.rpm /output

# -----------------------------------------------------------------------------
# Output directory for the resulting RPMs
# -----------------------------------------------------------------------------
CMD ["bash"]

