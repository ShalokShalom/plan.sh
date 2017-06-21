pkg_origin=cosmos

pkg_name=libomxil-bellagio
pkg_version=0.9.3
pkg_description="Opensource implementation of the OpenMAX Integration Layer --standard API to access Multimedia Components on mobile platforms"
pkg_upstream_url="http://omxil.sourceforge.net"
pkg_license=('LGPL')
pkg_deps=('glibc')
pkg_source=("http://downloads.sourceforge.net/project/omxil/omxil/Bellagio%200.9.3/${pkg_name}-${pkg_version}.tar.gz"
        'fedora-fixes.patch')
pkg_shasum=('a1de827fdb75c02c84e55f740ca27cb8'
         '39525202464b2306620395869766e0c3')

do_build() {
  patch -p1 -i ${CACHE_PATH}/fedora-fixes.patch
  autoreconf -fiv

  ./configure --prefix=/usr \
        --disable-static \
        --docdir=/usr/share/doc/${pkg_name}
  make
}

do_package() {

  make DESTDIR="${pkg_prefix}" install
}
