pkg_origin=

pkg_name=lyx
pkg_version=2.2.3
_pkg_version=2.2.3
pkg_description="An advanced open-source document processor."
pkg_upstream_url="http://www.lyx.org"
pkg_deps=('qt5-base' 'qt5-svg' 'qt5-x11extras' 'texlive-core' 'python2' 'perl' 'imagemagick' 'enchant' 
         'boost-libs' 'icu' 'libmythes' 'libxtst' 'aspell')
pkg_build_deps=('boost' 'bc' 'cmake' 'qt5-tools')
pkg_license=('GPL')
pkg_source=("ftp://ftp.lyx.org/pub/lyx/stable/2.2.x/$pkg_name-$pkg_version.tar.xz" 
#pkg_source=("ftp://ftp.lyx.org/pub/lyx/devel/lyx-2.2/lyx-${_pkg_version}/lyx-${_pkg_version}.tar.xz"
        'lyx.desktop'
        'qt5.8.diff')
pkg_shasum=('032147bf8e05040787b0fca43fd70de3'
         '0ea910b9b881ebaa0f79ebaa618930fd'
         'e42d658c62f159b6c66abca7cd6176f3')
         
do_prepare() {
  cd ${pkg_name}-${_pkg_version}
  # http://www.lyx.org/trac/changeset/6d375ddeac49ac8c6340398c9797354edca3f5d1/lyxgit
  #patch -p1 -i ${CACHE_PATH}/qt5.8.diff
  #sed -i 's|set(HUNSPELL_VERSION 1.3.3)|set(HUNSPELL_VERSION 1.6.0)|' 3rdparty/hunspell/CMakeLists.txt
}
         
do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${_pkg_version} \
    -DLYX_RELEASE=ON \
    -DLYX_INSTALL_PREFIX=/usr \
    -DLYX_DATA_SUBDIR=share/lyx2.2/ \
    -DLYX_MAN_DIR=/usr/share/man/man1 \
    -DLYX_USE_QT=QT5 \
    -DLYX_ASPELL=ON \
    -DLYX_ENCHANT=ON \
    -DLYX_HUNSPELL=OFF \
    -DLYX_EXTERNAL_BOOST=ON \
    -DLYX_INSTALL=ON
    
  make
  make translations
}

do_package() {
  cd build
  make DESTDIR=${pkg_prefix} install
  
  mv ${pkg_prefix}/usr/share/lyx2.2/locale ${pkg_prefix}/usr/share/locale
  mv ${pkg_prefix}/usr/applications ${pkg_prefix}/usr/share/applications
  mv ${pkg_prefix}/usr/icons ${pkg_prefix}/usr/share/icons
}

