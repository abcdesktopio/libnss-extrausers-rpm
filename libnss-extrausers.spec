Name:           libnss-extrausers
Version:        0.6
Release:        1%{?dist}
Summary:        NSS module to store passwd/group entries in separate files

License:        BSD
URL:            https://salsa.debian.org/debian/libnss-extrausers
Source0:        libnss-extrausers-0.6-autotools.tar.gz

BuildRequires:  gcc
BuildRequires:  make
BuildRequires:  autoconf
BuildRequires:  automake
BuildRequires:  libtool

# Install NSS module under /lib64 for Rocky Linux 9 (x86_64)
%global _libdir %{_prefix}/lib64

%description
The libnss-extrausers module allows storing passwd, group, shadow and gshadow
data in separate files under /var/lib/extrausers, instead of modifying the
system-wide /etc/passwd or /etc/group files. This is useful for containerized,
appliance or provisioning environments.

%prep
%setup -q -n libnss-extrausers-0.6

%build
# Standard autotools build
# ./configure --prefix=%{_prefix} --libdir=%{_libdir}
cp /Makefile /root/rpmbuild/BUILD/libnss-extrausers-0.6
make -j%{?_smp_build_ncpus}

%install
rm -rf %{buildroot}

# Install the module
make install DESTDIR=%{buildroot}/usr/lib64/
# Ensure extrausers directories exist
mkdir -p %{buildroot}/var/lib/extrausers

%files
# %license LICENSE
%doc README

# The NSS module
%{_libdir}/libnss_extrausers.so.2

# Data directory (empty but required)
%dir /var/lib/extrausers


%changelog
* Fri Dec 06 2024 ChatGPT <builder@example.com> - 0.6-1
- Initial RPM release with autotools build system

