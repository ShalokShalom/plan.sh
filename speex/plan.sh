pkg_origin=cosmos

pkg_name=speex
pkg_version=1.2.0
pkg_description="A free codec for free speech"
pkg_license=('BSD')
pkg_deps=('libogg' 'speexdsp')
pkg_source=("http://downloads.us.xiph.org/releases/speex/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('8ab7bb2589110dfaf0ed7fa7757dc49c')
pkg_upstream_url="http://www.speex.org/"

do_build() {
  
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm644 COPYING $CACHE_PATH/usr/share/licenses/${pkg_name}/LICENSE
}
