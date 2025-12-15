AC_INIT([libnss-extrausers], [0.6], [support@example.com])
AC_PREREQ([2.69])

AC_CONFIG_SRCDIR([src])
AC_CONFIG_AUX_DIR([build-aux])

AM_INIT_AUTOMAKE([foreign subdir-objects])

# Checks for programs
AC_PROG_CC

# Initialize libtool (required for NSS modules)
LT_INIT([dlopen])

# Enable silent rules (pretty build output)
AM_SILENT_RULES([yes])

# Check for required headers
AC_CHECK_HEADERS([pwd.h grp.h errno.h stdio.h stdlib.h string.h])

# Generate Makefiles
AC_CONFIG_FILES([
    Makefile
    src/Makefile
])

AC_OUTPUT

