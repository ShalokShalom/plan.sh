pkg_origin=

pkg_name=qisoburn
pkg_version=0.1
_commit=3311b0a847913b8979a656b5c14482b366f933d1
pkg_description="Qt-based GUI for burning image files into CD/DVD disks using growisofs from dvd+rw-tools."
pkg_upstream_url="https://code.google.com/archive/p/qisoburn/"
pkg_license=('LGPL')
pkg_deps=('qt5-base' 'dvd+rw-tools')
pkg_build_deps=('')
pkg_source=("https://github.com/KaOSx/qisoburn/archive/${_commit}.zip")
pkg_shasum=('c06ea50aec15076460eb7773bbeab42f')

do_build() {
   cd ${pkg_name}-${_commit}

   /usr/lib/qt5/bin/qmake qisoburn.pro
   make
}

do_package() {
   cd ${pkg_name}-${_commit}
   
   make INSTALL_ROOT=${pkg_prefix} install
}
