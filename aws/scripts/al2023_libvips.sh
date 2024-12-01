#!/bin/bash
set -x

sudo su - root

INSTALL_DIR=/usr/local

if [ ! -e ${INSTALL_DIR}/bin/vips ]; then

  VIPS_VERSION=8.15.2

  # Dependencies
  dnf --quiet --assumeyes update
  dnf --quiet --assumeyes groupinstall "Development Tools"
  dnf --quiet --assumeyes install wget tar meson pkgconf-pkg-config expat-devel glib2-devel

  # Optional dependencies
  dnf --quiet --assumeyes install libjpeg-turbo-devel libpng-devel giflib-devel libwebp-devel

  cd /tmp/
  wget https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.xz
  tar -xf vips-${VIPS_VERSION}.tar.xz
  cd vips-${VIPS_VERSION}
  meson setup build --prefix ${INSTALL_DIR}
  cd build
  meson compile # Takes ~2 mins on a t4g.micro
  meson install

  cd /tmp
  rm -rf /tmp/vips-${VIPS_VERSION}*

  echo "${INSTALL_DIR}/lib64" | tee /etc/ld.so.conf.d/local-lib64.conf
  ldconfig

  echo "Installed $(vips --version)"
fi
