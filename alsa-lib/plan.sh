pkg_origin=cosmos

pkg_name=alsa-lib
pkg_version=1.1.4.1
pkg_description="An alternative implementation of Linux sound support"
pkg_upstream_url="https://www.alsa-project.org"
pkg_deps=('glibc')
pkg_build_deps=('python2')
pkg_deps=('python2')
pkg_license=('GPL')
pkg_source=("ftp://ftp.alsa-project.org/pub/lib/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('29fa3e69122d3cf3e8f0e01a0cb1d183')

do_build() {

  ./configure --prefix=/usr \
        --with-pythonlibs="-lpthread -lm -ldl -lpython2.7" \
        --with-pythonincludes=-I/usr/include/python2.7
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
