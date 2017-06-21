pkg_origin=cosmos

pkg_name=gavl
pkg_version=1.4.0
pkg_description="A low level library, upon which multimedia APIs can be built."
pkg_upstream_url="http://gmerlin.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('glibc' 'libpng')
optios=('!libtool')
pkg_source=("https://downloads.sourceforge.net/sourceforge/gmerlin/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('2752013a817fbc43ddf13552215ec2c0')

do_build() {

  ./configure --prefix=/usr \
    --without-doxygen \
    --with-cpuflags=none
  make
}

do_package() {
  
  make DESTDIR=$pkg_prefix install
}
