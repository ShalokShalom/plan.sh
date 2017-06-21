pkg_origin=

pkg_name=rkward
pkg_version=0.6.9.3
_commit=d675e69bcc1aff8cc9615a4c23d9d11420010867
pkg_description="Provides an easily extensible, easy to use IDE/GUI for R."
pkg_upstream_url="http://rkward.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('kcoreaddons' 'ki18n' 'kxmlgui' 'ktexteditor' 'kwidgetsaddons' 'kdewebkit' 'kparts' 'knotifications'
         'kwindowsystem' 'qt5-webkit' 'qt5-script' 'r')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'icu')
pkg_source=("https://github.com/KDE/rkward/archive/${_commit}.zip")
pkg_shasum=('c1b563eef811367c2800a3776b60ef41')

do_prepare() {
  cd ${pkg_name}-${_commit}
  
  #sed -i -e 's|V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd|V4.5-Based Variant V1.1//EN" "dtd/kdex45.dtd|' doc/rkwardplugins/index.docbook
  #sed -i -e 's|V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd|V4.5-Based Variant V1.1//EN" "dtd/kdex45.dtd|' doc/rkward/index.docbook
  #sed -i -e 's|V4.2-Based Variant V1.1//EN" "dtd/kdex.dtd|V4.5-Based Variant V1.1//EN" "dtd/kdex45.dtd|' doc/rkward/man-rkward.1.docbook
  #sed -i -e 's|-caption|-qwindowtitle|g' rkward/rkward.desktop
  
  scripts/import_translations.py es fr de nl
}

do_build() { 
  mkdir -p build
  cd build

  cmake ../${pkg_name}-${_commit} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DKDE_INSTALL_LIBEXECDIR=lib \
    -DKDE_INSTALL_LIBDIR=lib \
    -DKDE_INSTALL_SYSCONFDIR=/etc \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DR_LIBDIR="/usr/lib/R/library" \
    -DNO_R_XML=1 \
    -DBUILD_TESTING=OFF 
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
