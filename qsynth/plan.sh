pkg_origin=

pkg_name=qsynth
pkg_version=0.4.4
pkg_description="Qt GUI for FluidSynth"
pkg_upstream_url="http://qsynth.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('fluidsynth' 'qt5-base' 'qt5-x11extras')
pkg_build_deps=('qt5-tools')
pkg_source=("http://downloads.sourceforge.net/qsynth/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('cf482f89d02d311e05145205e7c86b48')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  #CXXFLAGS="-std=c++11"

  ./configure --prefix=/usr 
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix} install
}
