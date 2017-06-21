pkg_origin=

pkg_name=freecad
_pkg_name=FreeCAD
pkg_version=0.16.1
_commit=fb62c9136642487fc7248ad50df317dfaffbafb6
pkg_description='A general purpose 3D CAD modeler'
pkg_upstream_url='http://www.freecadweb.org/'
pkg_license=('GPL')
pkg_deps=('boost-libs' 'curl' 'opencascade' 'pyqt5-python2' 'xerces-c' 'libspnav'
         'shared-mime-info' 'hicolor-icon-theme' 'python2-matplotlib' 'shiboken' 
         'python2-pyside-tools' 'qtwebkit-tp' 'med' 'coin') #pivy
pkg_build_deps=('boost' 'eigen3' 'swig' 'desktop-file-utils' 'cmake')
#pkg_source=("https://github.com/FreeCAD/FreeCAD/archive/${pkg_version}.tar.gz"
pkg_source=("https://github.com/FreeCAD/FreeCAD/archive/${_commit}.zip"
        'freecad.desktop'
        'freecad.xml')
pkg_shasum=('7817577e4916d7c584f38964cc8974c9'
         '0a4d0635dbd97d9f594ac8e927284316'
         'c2f4154c8e4678825411de8e7fa54c6b')

         
do_build() {
  cd ${_pkg_name}-${_commit}/
  # boost 1.60.0 fix, part of https://github.com/FreeCAD/FreeCAD/commit/e0683f4db0fb56f8139f78ca2e500b21ec2a67f0
  #sed -i 's|boost::re_detail::string_out_iterator<std::string > out(newfragment);|std::back_insert_iterator<std::string> out(newfragment);|' src/Mod/Drawing/App/FeaturePage.cpp

  mkdir -p build
  cd build

  cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/${pkg_name} .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DOCC_INCLUDE_DIR:PATH=/opt/opencascade/inc/ \
        -DOCC_LIBRARY_DIR:PATH=/opt/opencascade/Linux/lib \
        -DFREECAD_USE_EXTERNAL_PIVY:BOOL=OFF \
        -DBUILD_QT5=ON \
        -DBUILD_SMESH=ON 
  make

  # Builds Qt plugin, seems not part of the source in 0.14
  #cd ../src/Tools/plugins/widget/
  #qmake plugin.pro
  #make
}

do_package() {
  cd ${_pkg_name}-${_commit}/build

  # Install main program
  make DESTDIR=${pkg_prefix} install

  # Symlink to /usr/bin
  mkdir -p ${pkg_prefix}/usr/bin/
  ln -sf /opt/${pkg_name}/bin/FreeCAD ${pkg_prefix}/usr/bin/freecad
  ln -sf /opt/${pkg_name}/bin/FreeCADCmd ${pkg_prefix}/usr/bin/freecadcmd

  # Installs Qt plugin
  #install -Dm755 ../src/Tools/plugins/widget/libFreeCAD_widgets.so "${pkg_prefix}/usr/lib/qt/plugins/designer/libFreeCAD_widgets.so"

  # Install pixmaps and desktop shortcut
  desktop-file-install \
    --dir=${pkg_prefix}/usr/share/applications ${CACHE_PATH}/${pkg_name}.desktop

   # Mime info
   install -D -m644 ${CACHE_PATH}/${pkg_name}.xml ${pkg_prefix}/usr/share/mime/packages/${pkg_name}.xml
}

