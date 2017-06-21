pkg_origin=cosmos

pkg_name=rtkit
pkg_version=0.11
pkg_description="Realtime Policy and Watchdog Daemon"
pkg_upstream_url="http://0pointer.de/blog/projects/rtkit"
pkg_license=('GPL' 'custom:BSD')
pkg_deps=('dbus' 'polkit' 'systemd')
install=rtkit.install
pkg_source=("http://0pointer.de/public/${pkg_name}-${pkg_version}.tar.xz"
        'libsystemd.patch'
        'cgroup.patch')
pkg_shasum=('a96c33b9827de66033d2311f82d79a5d'
         '217997fc8f38ce45a798e66256e4f94d'
         '95195a70551057aca833da6bdbf2e35b')

do_build() {
  patch -p1 -i ${CACHE_PATH}/libsystemd.patch
  patch -p1 -i ${CACHE_PATH}/cgroup.patch
  
  autoreconf -fi
  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --libexecdir=/usr/lib/rtkit \
    --with-systemdsystemunitdir=/usr/lib/systemd/system

  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  mkdir -p ${CACHE_PATH}/usr/share/dbus-1/interfaces
  ./rtkit-daemon --introspect >${CACHE_PATH}/usr/share/dbus-1/interfaces/org.freedesktop.RealtimeKit1.xml

  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/$pkg_name/LICENSE
  sed -ne '4,25p' rtkit.c >${CACHE_PATH}/usr/share/licenses/rtkit/COPYING
}


