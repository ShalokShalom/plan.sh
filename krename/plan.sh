pkg_origin=
 
pkg_name=krename
pkg_version=4.0.9.70
_commit=71203fdd28edb2e5b74c41fcbedadf12a2f0577e
pkg_description="Powerful batch renamer for KDE."
pkg_upstream_url="http://www.krename.net/"
pkg_license=('GPL')
pkg_deps=('kcompletion' 'kconfig' 'kcoreaddons' 'kcrash' 'ki18n' 'kiconthemes' 'kitemviews' 'kjobwidgets'
         'kjs' 'kio' 'kservice' 'kwidgetsaddons' 'kxmlgui' 'taglib' 'exiv2' 'podofo')
pkg_build_deps=('extra-cmake-modules' 'kdoctools')
pkg_source=("https://github.com/KDE/krename/archive/${_commit}.zip")
pkg_shasum=('08f4eb3a0c83b1d0031d01fd9586379e')
 
do_build() {
  mkdir -p build
  cd build
 
  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBDIR=lib
  make
}
 
do_package() {
  cd build
 
  make DESTDIR=${pkg_prefix} install
}
