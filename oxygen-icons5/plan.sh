pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

_origname=oxygen-icons5
pkg_name=('oxygen-icons5' 'oxygen-icons5-svg')
pkg_version=${_kf5ver}
pkg_description="split package"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL' 'LGPL' 'FDL')
pkg_build_deps=('extra-cmake-modules')
pkg_source=($_mirror/${_origname}-$_kf5ver.tar.xz)
pkg_shasum=(`grep ${_origname}-$_kf5ver.tar.xz ../kf5.md5 | cut -d" " -f1`)

build () {  
  mkdir -p build
  cd build
  
  cmake ../${_origname}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DLIB_INSTALL_DIR=lib \
    -DQML_INSTALL_DIR=/usr/lib/qt5/qml \
    -DPLUGIN_INSTALL_DIR=/usr/lib/qt5/plugins \
    -DKDE_INSTALL_USE_QT_SYS_PATHS=ON 
  make
}

package_oxygen-icons5() {
    pkg_description="Oxygen Icons theme"
    conflicts=('oxygen-icons')
    replaces=('oxygen-icons')
    provides=('oxygen-icons')
	
    cd build
	
    make DESTDIR=${pkg_prefix} install 
    # conflicts with kdepim
    #rm ${pkg_prefix}/usr/share/icons/oxygen/*/mimetypes/x-mail-distribution-list.png
}

package_oxygen-icons5-svg() {
    pkg_description="Oxygen (Emot)Icons - SVG Sources"
    conflicts=('oxygen-icons-svg')
    replaces=('oxygen-icons-svg')
	
    cd $_origname-${pkg_version}
    find scalable -type f ! -name '*.sh' -exec \
        install -D -m644 "{}" "${pkg_prefix}/usr/share/icons/oxygen/{}" \;
}
