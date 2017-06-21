pkg_origin=cosmos

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

# check in tools/scripts/version_resolver.py for used Chromium
# on major updates build twice, first without building examples/qtwebengine dep
# rebuild all in "required by" on major updates
pkgbase=qtwebengine
pkg_name=('qtwebengine' 'qtwebengine-examples')
pkg_version=${qtver}
subver=${subver}
_pkg_version=${_qtver}
pkg_description="Chromium-based web engine to replace Qt WebKit"
pkg_upstream_url="http://blog.qt.digia.com/blog/2014/01/23/qt-webengine-technology-preview-available/"
pkg_license=('GPL3')
pkg_build_deps=('qt5-declarative' 'python2-jinja' 'mesa' 'systemd' 'pango' 'nss' 'speex' 'libevent' 'libcups'
         'libxslt' 'libpng' 'libjpeg-turbo' 'libwebp' 'zlib' 'pciutils' 'jsoncpp' 'pulseaudio' 'libxcomposite'
         'qt5-location' 'qt5-webchannel' 'ffmpeg' 'libxss' 'protobuf' 'opus' 'libvpx'
         'gperf' 'yasm' 'openssh' 'icu' 'qtwebengine')
_pkgfqn="qtwebengine-opensource-src-${subver}"
pkg_source=("${_qtmirror}/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz"
#pkg_source=("https://download.qt-project.org/development_releases/qt/${_pkg_version}/${subver}/submodules/$_pkgfqn.tar.xz"
        'nss321.diff'
        'demobrowser.desktop'
        'quicknanobrowser.desktop'
        'markdowneditor.desktop')
pkg_shasum=(`grep ${_pkgfqn}.tar.xz ../qt.md5 | cut -d" " -f1`
         '5c297bd337ffab4a2d075a7c85d55ef3'
         'f11d24801322ef41f8a44eedc5e104c2'
         '6d62ba455c7d70870fb28c9362c9c591'
         '5ea5aa48c198a8de1398fc9e7a4abd14')

do_build() {
   
   mkdir build   
   #export GYP_DEFINES="python_ver=2.7 use_pulseaudio=1 use_pango=1 use_cairo=1 use_cups=1"
   
   /usr/lib/qt5/bin/qmake WEBENGINE_CONFIG+="use_proprietary_codecs use_system_ffmpeg use_spellchecker use_nss=0" ../qtwebengine.pro
   make 
   
   /usr/lib/qt5/bin/qmake
   make
   
   /usr/lib/qt5/bin/qmake
   make
   
   /usr/lib/qt5/bin/qmake
   make
}

package_qtwebengine() {
   pkg_description="Chromium-based web engine to replace Qt WebKit"
   pkg_deps=('qt5-declarative' 'python2-jinja' 'mesa' 'systemd' 'pango' 'nss' 'speex' 'libevent' 'libcups'
            'libxslt' 'libpng' 'libjpeg-turbo' 'libwebp' 'zlib' 'pciutils' 'jsoncpp' 'pulseaudio' 'libxcomposite'
            'qt5-webchannel' 'ffmpeg' 'libxss' 'protobuf' 'opus' 'libvpx')
    groups=('qt5')
            
   
   make INSTALL_ROOT="${CACHE_PATH}" install
}

package_qtwebengine-examples() {
    pkg_description="Chromium-based web engine examples browsers and editor"
    pkg_deps=('qtwebengine')
    
    
    install -D -m755 examples/webenginewidgets/demobrowser/demobrowser ${CACHE_PATH}/usr/bin/demobrowser
    install -D -m755 examples/webengine/quicknanobrowser/quicknanobrowser ${CACHE_PATH}/usr/bin/quicknanobrowser
    install -D -m755 examples/webenginewidgets/markdowneditor/markdowneditor ${CACHE_PATH}/usr/bin/markdowneditor
    
    install -D -m644 ${CACHE_PATH}/demobrowser.desktop ${CACHE_PATH}/usr/share/applications/demobrowser.desktop
    install -D -m644 ${CACHE_PATH}/quicknanobrowser.desktop ${CACHE_PATH}/usr/share/applications/quicknanobrowser.desktop
    install -D -m644 ${CACHE_PATH}/markdowneditor.desktop ${CACHE_PATH}/usr/share/applications/markdowneditor.desktop
    
    install -D -m644 examples/webenginewidgets/demobrowser/data/demobrowser.svg \
    ${CACHE_PATH}/usr/share/icons/hicolor/scalable/apps/demobrowser.svg
}
