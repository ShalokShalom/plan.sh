pkg_origin=

pkg_name=plasma-widget-quickaccess
pkg_version=0.8.2
_pkg_version=0.8.2-2
pkg_description="Kdeplasma applet for quick access to folders."
pkg_upstream_url="http://www.kde-look.org/content/show.php/QuickAccess+(maintenance+fork)?content=101968"
pkg_license=('GPL')
pkg_deps=('kde-workspace' 'kde-baseapps')
pkg_build_deps=('cmake' 'automoc4')
pkg_source=("http://kde-look.org/CONTENT/content-files/134442-plasma-widget-quickaccess-$_pkg_version.zip")
pkg_shasum=('4879aa3af6d7db8e06dd8ed0ad994a51')

do_build() {
    mkdir build
    cd build
    cmake ../${pkg_name}-${_pkg_version} \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` 
    make
}

do_package() {
    cd build
    
    make DESTDIR=$pkg_prefix install
}
