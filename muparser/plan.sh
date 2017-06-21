pkg_origin=cosmos

pkg_name=muparser
pkg_version=2.2.5
pkg_description="Fast math parser library"
pkg_upstream_url="http://muparser.beltoforion.de/"
pkg_deps=('gcc-libs')
pkg_license=('custom')
pkg_source=("https://github.com/beltoforion/muparser/archive/v${pkg_version}.tar.gz")
pkg_shasum=('02dae671aa5ad955fdcbcd3fee313fb7')

do_build() {
  
  sh ./configure --prefix=/usr
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  install -D -m644 License.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
