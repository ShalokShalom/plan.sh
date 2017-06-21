pkg_origin=cosmos

pkg_name=libmikmod
pkg_version=3.3.11
pkg_description="A portable sound library"
pkg_license=('GPL' 'LGPL')
pkg_upstream_url="http://mikmod.shlomifish.org/"
pkg_deps=('glibc' 'sh' 'pulseaudio')
pkg_build_deps=('alsa-lib')
pkg_source=("https://downloads.sourceforge.net/mikmod/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('fc7557cdbd78692d1e64d057cba09992')

do_build() {
  
  ./configure --prefix=/usr \
        --mandir=/usr/share/man \
        --infodir=/usr/share/info \
        --disable-static
  make
}

do_package() {
  
  make DESTDIR=$pkg_prefix install
}

