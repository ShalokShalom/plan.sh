pkg_origin=cosmos

pkg_name=enca
pkg_version=1.19
pkg_description="Detects character set and encoding of text files and can also convert them to other encodings"
pkg_upstream_url="http://cihar.com/software/enca/"
pkg_license=('GPL')
pkg_deps=('bash')
pkg_source=("http://dl.cihar.com/enca/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('a7a0c152658e012db701a48ae8b79525')

do_build() {

  ./configure --prefix=/usr \
              --libexecdir=/usr/lib \
              --mandir=/usr/share/man \
              --without-librecode \
              --enable-external
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
