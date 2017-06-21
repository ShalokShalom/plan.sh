pkg_origin=cosmos

pkg_name=libmbim
pkg_version=1.14.0
pkg_description="Glib-based library for talking to WWAN modems and devices which speak the Mobile Interface Broadband Model"
pkg_upstream_url="https://www.freedesktop.org/wiki/Software/libmbim/"
pkg_license=('GPL2')
pkg_deps=('glib2' 'bash' 'libgudev' 'systemd')
pkg_build_deps=('python2' 'vala')
pkg_source=("https://www.freedesktop.org/software/libmbim/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('2ed809e65c85353d3ab59e372890e549')

do_build() {

  ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --libexecdir=/usr/lib \
        --localstatedir=/var \
        --disable-static 
        
  make
}

check() {

  make check
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
