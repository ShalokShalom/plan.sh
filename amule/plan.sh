pkg_origin=

pkg_name=amule
pkg_version=2.3.2.1
_commit=88364ced28850a14c0df1c2235692956db883b32
epoch=2
pkg_description="An eMule-like client for ed2k p2p network"
pkg_upstream_url="http://www.amule.org"
pkg_license=('GPL')
pkg_deps=('wxgtk' 'gd' 'geoip' 'libupnp' 'crypto++' 'boost-libs')
pkg_build_deps=('boost')
pkg_source=("https://github.com/amule-project/amule/archive/${_commit}.zip")
#pkg_source=("https://sourceforge.net/projects/amule/files/aMule/${pkg_version}/aMule-${pkg_version}.tar.xz")
pkg_shasum=('23a74c39df129446b266cff36d284692')

do_build() {
  cd amule-${_commit}

  ./autogen.sh
  ./configure --prefix=/usr \
              --mandir=/usr/share/man \
              --enable-cas \
              --enable-wxcas \
              --enable-amule-daemon \
              --enable-amulecmd \
              --enable-amule-gui \
              --enable-alc \
              --enable-alcc \
              --enable-webserver \
              --disable-debug \
              --enable-optimize \
              --enable-geoip \
              --enable-upnp \
              --with-wx-config=wx-config \
              --with-boost

  make 
}

do_package() {
  cd amule-${_commit}
  
  make DESTDIR=${pkg_prefix}/ install 
  # conflict with glibc
  #rm "${pkg_prefix}/usr/share/locale/locale.alias"
}

