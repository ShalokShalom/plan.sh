pkg_origin=cosmos

pkg_name=lcms
pkg_version=1.19
pkg_description="Lightweight color management development library/engine"
pkg_license=('custom')
pkg_deps=('libtiff')
pkg_upstream_url="http://www.littlecms.com"
pkg_source=("http://downloads.sourceforge.net/sourceforge/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
        'cve-2013-4276.patch')
pkg_shasum=('8af94611baf20d9646c7c2c285859818'
         'ab1161c0d09952c0e4d18cdedcef426a')

do_build() {
  patch -p1 -i ${CACHE_PATH}/cve-2013-4276.patch
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
  install -Dm 644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
