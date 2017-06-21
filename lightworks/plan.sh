pkg_origin=
 
pkg_name=lightworks
pkg_version=14.0.0.12
_pkg_version=14.0.0
_beta=93046
pkg_description="A professional video editing software"
pkg_upstream_url="http://www.lwks.com/"
pkg_license=('custom')
install="${pkg_name}.install"
pkg_deps=('gtk3' 'portaudio' 'libgl' 'glu' 'ffmpeg' 'libedit' 'libtiff' 'nvidia-cg-toolkit' 'libgsf')
pkg_source=("http://downloads.lwks.com/v14/lwks-${_pkg_version}-amd64.deb"
        'libportaudio.so.2.0.0'
        'libportaudiocpp.so.0.0.12')
pkg_shasum=('17a60e8c2956f65dd578a14cf673b0d4'
         'acfd08eb31cadb75a3a0e86cce54220b'
         'e9e13d426aab9dcf15a7dc81c21e6396')

noextract=("lwks-${pkg_version}-amd64.deb")
 
do_package() {
  bsdtar -xf "lwks-${_pkg_version}-amd64.deb" data.tar.xz  
  bsdtar -xf data.tar.xz -C "${pkg_prefix}"
	rm data.tar.xz
  
  mv -f ${pkg_prefix}/lib/udev ${pkg_prefix}/usr/lib
  rmdir ${pkg_prefix}/lib
  #fix icon path in .desktop file
  sed -i 's|Icon=/usr/share/lightworks/Icons/App.png|Icon=lightworks|' \
   ${pkg_prefix}/usr/share/applications/lightworks.desktop
  
  mkdir -p ${pkg_prefix}/usr/share/licenses/lightworks/
  mv -f ${pkg_prefix}/usr/share/doc/lightworks/copyright ${pkg_prefix}/usr/share/licenses/lightworks/
  rm -rf ${pkg_prefix}/usr/share/doc
  
  # add portaudio 19.1 libs until upstream ready for newer
  cp ${CACHE_PATH}/libportaudio.so.2.0.0 ${pkg_prefix}/usr/lib/lightworks/
  cp ${CACHE_PATH}/libportaudiocpp.so.0.0.12 ${pkg_prefix}/usr/lib/lightworks/
  
  cd ${pkg_prefix}/usr/lib/lightworks/
  ln -s libportaudio.so.2.0.0 libportaudio.so
  ln -s libportaudio.so.2.0.0 libportaudio.so.2
  ln -s libportaudiocpp.so.0.0.12 libportaudiocpp.so
  ln -s libportaudiocpp.so.0.0.12 libportaudiocpp.so.0
}
