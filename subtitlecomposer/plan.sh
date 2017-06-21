pkg_origin=

pkg_name=subtitlecomposer
pkg_version=0.6.4
pkg_description="Open source text-based subtitle editor that supports basic and more advanced operations "
pkg_upstream_url="https://github.com/maxrd2/subtitlecomposer"
pkg_license=('GPL')
pkg_deps=('kauth' 'kconfig' 'kconfigwidgets' 'kcoreaddons' 'ki18n' 'kio' 'kxmlgui' 'sonnet'
         'kross' 'kcodecs' 'ktextwidgets' 'kwidgetsaddons' 'khtml' 
         'gettext' 'mplayer' 'mpv' 'icu')
pkg_build_deps=('extra-cmake-modules')
pkg_source=("https://github.com/maxrd2/${pkg_name}/archive/v${pkg_version}.tar.gz"
        "https://github.com/maxrd2/subtitlecomposer/commit/a62048cd9c458de856b3bcfd3a96164ca5017350.diff")
#pkg_source=("https://github.com/maxrd2/subtitlecomposer/archive/${_commit}.zip")
pkg_shasum=('d16f5c94d763c2ee0c1fa039f029d161'
         '342c57ec1026b6943a4c26e60bcdc625')

do_prepare() {
  cd $pkg_name-${pkg_version}
  patch -p1 -Ri ${CACHE_PATH}/a62048cd9c458de856b3bcfd3a96164ca5017350.diff
  #sed -i -e 's|KF5::SonnetUi|KF5::SonnetUi KF5::KHtml|' src/common/CMakeLists.txt
  #sed -i -e 's|I18n KIO XmlGui|I18n KIO KHtml XmlGui|' CMakeLists.txt
}

do_build() {
    mkdir -p build
    cd build

    cmake ../${pkg_name}-${pkg_version} \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
        -DKDE_INSTALL_LIBDIR=lib
    make
}

do_package() {
    cd build

    make DESTDIR=${pkg_prefix} install
}
