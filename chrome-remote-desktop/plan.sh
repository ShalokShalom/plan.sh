pkg_origin=

pkg_name=chrome-remote-desktop
pkg_version=59.0.3071.47
pkg_description="Access other computers or allow another user to access your computer securely over the Internet using Chrome"
pkg_upstream_url="https://chrome.google.com/webstore/detail/gbchcmhmhahfdphkhkmpfmihenigjmpp"
pkg_license=('BSD')
install=${pkg_name}.install
pkg_deps=('python2' 'python2-psutil' 'gconf' 'gtk2' 'nss' 'xorg-utils' 'xorg-server' 'xorg-xkb-utils' 
         'xorg-xauth' 'nano')
pkg_source=("http://dl.google.com/linux/chrome-remote-desktop/deb/pool/main/c/${pkg_name}/${pkg_name}_${pkg_version}_amd64.deb"
        'chrome-remote-desktop.service'
        'crd')
pkg_shasum=('2edc99e417685fed9185eb294630fbbc'
         '6f6083ff37f036f590702c7b1319445b'
         'b6f440ffccc35237d2a043ec52027130')

do_build() {
  cd ${CACHE_PATH}
  
  bsdtar -xf data.tar.xz -C .

  rm -R etc/cron.daily
  rm -R etc/init.d
  rm -R etc/pam.d
}

do_package() {
  cd ${CACHE_PATH}

  mv etc ${pkg_prefix}
  mv opt ${pkg_prefix}

  install -Dm644 usr/share/doc/${pkg_name}/copyright ${pkg_prefix}/usr/share/licenses/${pkg_name}/copyright
  install -Dm644 ${pkg_name}.service ${pkg_prefix}/usr/lib/systemd/user/${pkg_name}.service
  install -Dm755 crd ${pkg_prefix}/usr/bin/crd
}
