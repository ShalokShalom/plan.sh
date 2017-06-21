pkg_origin=cosmos

pkg_name=speexdsp
pkg_version=1.2rc3
pkg_description="Speex DSP library with NEON optimizations"
pkg_upstream_url="http1://www.speex.org/"
pkg_license=('BSD')
pkg_deps=('glibc')
pkg_source=("http://downloads.us.xiph.org/releases/speex/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('70d9d31184f7eb761192fd1ef0b73333')

do_build() {
  
  ./configure --prefix=/usr \
       --sysconfdir=/etc \
       --localstatedir=/var
  make
}

do_package() {
  make DESTDIR=${CACHE_PATH} install

  install -Dm644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
