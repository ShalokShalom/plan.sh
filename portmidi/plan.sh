pkg_origin=

pkg_name=portmidi
pkg_version=217
pkg_description="Cross-platform, open-source I/O libraries for digital media including MIDI, video, and audio"
pkg_upstream_url="http://portmedia.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('alsa-lib')
pkg_build_deps=('cmake' 'java-environment')
optpkg_deps=('java-runtime: for using pmdefaults')
pkg_source=("https://downloads.sourceforge.net/project/portmedia/portmidi/${pkg_version}/${pkg_name}-src-${pkg_version}.zip"
        'java.patch')
pkg_shasum=('03f46fd3947e2ef4c8c465baaf832241'
         '59cb428b29a33bab3bb5811cda479a9b')

do_prepare() {
  cd ${pkg_name}
  sed -i "s|/usr/local|/usr|" */CMakeLists.txt pm_python/setup.py
  mkdir -p pm_java/Release

  patch -p1 -i ${CACHE_PATH}/java.patch 
}

do_build() {
  cd ${pkg_name}
  
  cmake . -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=Release \
    -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=Release \
    -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=Release
  make
}

do_package() {
  cd ${pkg_name}
  make DESTDIR=${pkg_prefix} install

  ln -s libportmidi.so ${pkg_prefix}/usr/lib/libporttime.so
}
