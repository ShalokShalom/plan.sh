pkg_origin=cosmos

pkg_name=frei0r-plugins
pkg_version=1.6.1
_pkg_version=snapshot-27-01-15
pkg_description="Large collection of free and portable video plugins"
pkg_upstream_url="https://www.dyne.org/software/frei0r/"
pkg_license=('GPL')
pkg_deps=('gcc-libs' 'gavl' 'opencv')
pkg_build_deps=('doxygen')
pkg_source=("https://files.dyne.org/frei0r/${pkg_name}-${pkg_version}.tar.gz")
#pkg_source=("git://code.dyne.org/frei0r.git"
#pkg_source=("https://files.dyne.org/frei0r/snapshots/frei0r-${_pkg_version}.tar.gz"
#        "http://www.linuxfromscratch.org/patches/blfs/7.9/frei0r-snapshot-27-01-15-gcc5_fix-1.patch"
#        'facedetect.diff')
pkg_shasum=('bb85573340029e5d0ae1c21d0685461d')

prepare() {
  
  #patch -p1 -i ${CACHE_PATH}/frei0r-snapshot-27-01-15-gcc5_fix-1.patch
  touch README AUTHORS ChangeLog TODO
  sed -i -e 's|AC_INIT(frei0r-plugins, [1.5.0]|AC_INIT(frei0r-plugins, [1.6.0]|g' configure.ac
  sed -i -e 's|AM_INIT_AUTOMAKE|AM_INIT_AUTOMAKE([foreign])|g' configure.ac
}
         
do_build() {

  ./autogen.sh
  ./configure --prefix=/usr 
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}


