pkg_origin=

pkg_name=qjackctl
pkg_version=0.4.5
pkg_description="Qt front-end for the JACK low-latency audio server"
pkg_upstream_url="http://qjackctl.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('jack' 'qt5-base' 'qt5-x11extras' 'portaudio')
pkg_build_deps=('qt5-tools')
pkg_source=("http://downloads.sourceforge.net/qjackctl/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('2f8697891942403d7782e173704110c9')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  #CXXFLAGS="-std=c++11"

 ./configure --prefix=/usr
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix}/ install
}
