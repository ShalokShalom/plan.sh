pkg_origin=

pkg_name=plasma-applet-redshift-control
pkg_version=1.0.18
_commit=b45d454a6d0e8db022dd963cc50a59ccbda7f1c7
pkg_description='Plasmoid for enabling and disabling redshift process, providing simple settings and mouse-wheel screen temperature control.'
pkg_upstream_url='http://kde-apps.org/content/show.php/Redshift+Control?content=170746'
pkg_license=('GPL')
pkg_deps=('plasma-desktop' 'redshift')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://github.com/kotelnik/plasma-applet-redshift-control/archive/v${pkg_version}.tar.gz")
pkg_shasum=('5aab255007ba319fe9c4c73d45bb8d05')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON 
  make
}

do_package() {
  cd build
  
  make DESTDIR="$pkg_prefix" install
}
