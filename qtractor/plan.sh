pkg_origin=

pkg_name=qtractor
pkg_version=0.8.2
pkg_description="Audio/MIDI multitrack sequencer"
pkg_upstream_url="http://qtractor.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('qt5-x11extras' 'suil' 'lilv' 'libmad' 'libsamplerate' 'rubberband' 'liblo' 'shared-mime-info')
pkg_build_deps=('ladspa' 'dssi' 'qt5-tools')
pkg_source=("http://www.rncbc.org/archive/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('4300eed100384e02a969ff528b1c8169')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  #CXXFLAGS="-std=c++11"

  ./configure --prefix=/usr --enable-debug
  make
}

package () {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix}/ install
}

