pkg_origin=

pkg_name=midna-themes
pkg_version=2.0.4
pkg_description='KaOS Plasma 5 Look & Feel theme files'
pkg_upstream_url='http://kaosx.us'
pkg_license=('LGPL')
pkg_deps=('plasma-framework' 'qtcurve' 'ttf-raleway')
pkg_build_deps=('extra-cmake-modules')
           'kde-ksplash-themes-midna'
           'kde-plasma-themes-midna' 
           'midna-colors' 
           'wallpapers-midna')
          'kde-ksplash-themes-midna'
          'kde-plasma-themes-midna' 
          'midna-colors' 
          'wallpapers-midna')
pkg_source=("git://github.com/KaOSx/midna.git")
pkg_shasum=('SKIP')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../midna \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON  
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
