pkg_origin=cosmos

pkg_name=media-player-info
pkg_version=22
pkg_description="Data files describing media player capabilities, for post-HAL systems"
pkg_license=('BSD')
pkg_upstream_url="http://cgit.freedesktop.org/media-player-info/"
pkg_deps=('systemd' 'python3')
install=$pkg_name.install
pkg_source=("https://www.freedesktop.org/software/media-player-info/${pkg_name}-${pkg_version}.tar.gz"
        'udev_errors.patch')
pkg_shasum=('2d4b94104e2266ed4a8ae306086e4243'
         '83d787203ff5192141e82d9dfabb11c6')

do_build() {
  #patch -p1 -i ${CACHE_PATH}/udev_errors.patch

  ./configure --prefix=/usr --with-udevdir=/usr/lib/udev
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -d ${pkg_prefix}/usr/share/licenses/$pkg_name
  install -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}
}
