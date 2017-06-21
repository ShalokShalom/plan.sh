pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=qt5-webkit
#pkg_version=${qtver}
pkg_version=5.8.0beta
subver=5.8.0-beta
_pkg_version=${_qtver}
pkg_description=('A cross-platform application and UI framework, QtWebkit files')
pkg_upstream_url='http://qt.nokia.com/'
pkg_license=('GPL3' 'LGPL' 'FDL')
pkg_deps=('qt5-sensors' 'qt5-location' 'qt5-quickcontrols' 'icu' 'libxslt' 'libxcomposite' 
         'gst-plugins-base' 'gst-plugins-good' 'libwebp' 'mesa' 'qt5-serialport' 'qt5-multimedia'
         'qt5-imageformats' 'gst-libav' 'gst-plugins-bad') # 'qt5-webchannel' 
pkg_build_deps=('gperf' 'sqlite' 'fontconfig' 'perl' 'python2' 'ruby') # 'qt5-tools')
groups=('qt5')
_pkgfqn="qtwebkit-opensource-src-${subver}"
pkg_source=("http://download.qt.io/community_releases/${_pkg_version}/${subver}/$_pkgfqn.tar.xz"
        'default_prf.patch')
#pkg_source=("http://download.qt-project.org/development_releases/qt/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz")
#pkg_shasum=(`grep ${_pkgfqn}.tar.xz ../qt.md5 | cut -d" " -f1`)
pkg_shasum=('0d65d15c20d62e0a095d3ad8553b2905'
         '6dd34ad8ffa508a894a5e87f8e96015e')

do_prepare() {

  patch -p1 -i $CACHE_PATH/default_prf.patch
  #syncqt.pl-qt5 -version 5.6.0 Source/sync.profile
}

do_build() {
	
   /usr/lib/qt5/bin/qmake
   make
}

do_package() {
   make INSTALL_ROOT=$CACHE_PATH install
    
   #mkdir -p ${CACHE_PATH}/usr/bin
   #for i in $(ls ${CACHE_PATH}/usr/lib/qt5/bin); do
   #    ln -s /usr/lib/qt5/bin/${i} ${CACHE_PATH}/usr/bin/${i}-qt5
   #done
}

