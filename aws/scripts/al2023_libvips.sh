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

echo """

インストールが終了しました。
この後はec2-userに切り替えて作業してください。（例:'sudo su - ec2-user'）
'code tunnel --accept-server-license-terms' を起動し、表示されたURLと8桁のcodeを使ってこのサーバーをgithubアカウントで認証してください。
その後、サーバーに表示された'http://vscode.dev/tunnel/****'のURLからアクセスできるようになります。
サーバーのOSを停止した場合、再度'code tunnel --accept-server-license-terms'を実行してください。

## English

Installation is complete.
Switch to ec2-user and work. (e.g. 'sudo su - ec2-user')
Run 'code tunnel --accept-server-license-terms' and authenticate this server with your github account using the URL and 8-digit code displayed.
After that, you can access the server from the URL 'http://vscode.dev/tunnel/****' displayed on the server.
If you stop the server OS, run 'code tunnel --accept-server-license-terms' again.
"""
