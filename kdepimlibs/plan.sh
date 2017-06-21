pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kdepimlibs
pkg_version=${_kdever}
pkg_description="KDE Pim Libraries"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_deps=('akonadi' 'kio' 'kcompletion' 'kcodecs' 'phonon-qt5' 'kcontacts' 'kcalcore'
         'kmime' 'ki18n' 'kitemviews' 'kconfig' 'solid' 'qt5-tools' 'kldap' 'kmbox' 
         'prison' 'qtwebengine' 'grantlee')
pkg_build_deps=('extra-cmake-modules' 'boost' 'kdoctools')
pkg_source=($_mirror/${pkg_name}-${_kdever}.tar.xz
        'itemsync1.diff'
        'itemsync2.diff'
        'itemsync3.diff')
pkg_shasum=(`grep ${pkg_name}-${_kdever}.tar.xz ../kde-sc.md5 | cut -d" " -f1`
         '94e081a9dec1c75200741674a6536dc4'
         '23c11a9ff08eb450e80359defdc9375b'
         '5d8efca67dcc880ccefa710b265b36fd')
#pkg_source=("git://anongit.kde.org/kdepimlibs.git")      
#pkg_shasum=('SKIP')

do_prepare() {
    cd $pkg_name-${pkg_version}
  
    #patch -p1 -i $CACHE_PATH/itemsync1.diff
    #patch -p1 -i $CACHE_PATH/itemsync2.diff
    #patch -p1 -i $CACHE_PATH/itemsync3.diff
}

do_build() {
    mkdir -p build
    cd build

    cmake ../${pkg_name}-${pkg_version} \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCMAKE_SKIP_RPATH=ON \
	-DKDE_INSTALL_LIBDIR=lib \
	-DKDE_INSTALL_USE_QT_SYS_PATHS=ON \
    -DQTWEBENGINE_EXPERIMENTAL_OPTION=TRUE  
                
    make # -j8 sb_all
}

do_package() {
    cd build
	
    make DESTDIR=${pkg_prefix} install
}
