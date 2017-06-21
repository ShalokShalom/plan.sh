pkg_origin=

pkg_name=fcitx-anthy
pkg_version=0.2.2
pkg_description="Anthy Wrapper for Fcitx, ported from scim-anthy."
pkg_upstream_url="http://code.google.com/p/fcitx"
pkg_license=('GPL')
pkg_deps=('fcitx' 'anthy')
pkg_build_deps=('cmake' 'intltool')
pkg_source=("http://download.fcitx-im.org/fcitx-anthy/$pkg_name-$pkg_version.tar.xz")
pkg_shasum=('956660d67900f59fa7fd80d68cc4ad7c')

do_build(){
  cd ${pkg_name}-${pkg_version}

  cmake -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release .
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix} install
}
