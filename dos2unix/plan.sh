pkg_origin=cosmos

pkg_name=dos2unix
pkg_version=7.3.4
pkg_description='Text file format converter'
pkg_upstream_url='https://waterlan.home.xs4all.nl/dos2unix.html'
pkg_license=('BSD')
pkg_deps=('glibc')
pkg_build_deps=('perl')
pkg_source=("https://waterlan.home.xs4all.nl/dos2unix/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('04428e77e2ead8a92c1492ba8977f1d1')

do_build() {

  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -D -m644 COPYING.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
