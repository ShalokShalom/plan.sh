pkg_origin=

pkg_name=python2-pyside
_pkg_name=PySide
pkg_version=1.2.4
pkg_description="Provides LGPL Qt bindings for Python and related tools for binding generation."
pkg_license=('LGPL')
pkg_upstream_url="http://www.pyside.org"
_qtver=4.8
pkg_deps=('qt' 'phonon' 'qtwebkit' "shiboken>=${pkg_version}")
pkg_build_deps=('cmake')
pkg_source=("https://github.com/PySide/PySide/archive/${pkg_version}.tar.gz")
pkg_shasum=('c28563e1f3c3ce269a7cc634f97d271c')

build () {
  cd ${_pkg_name}-${pkg_version}
  mkdir -p build 
  cd build
  
  cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
           -DCMAKE_BUILD_TYPE=Release \
           -DBUILD_TESTS=OFF 
  make
}

do_package() {
    cd ${_pkg_name}-${pkg_version}/build
    
    make DESTDIR=$pkg_prefix install
}
