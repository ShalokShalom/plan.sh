pkg_origin=

pkg_name=kid3
pkg_version=3.5.0
pkg_description="Easily tag multiple MP3, Ogg/Vorbis, FLAC, MPC, MP4/AAC, and more, plus have control over both ID3v1 and ID3v2 tags"
pkg_upstream_url="https://kid3.sourceforge.net/"
pkg_license=('GPL')
pkg_deps=('qt5-declarative' 'libmp4v2' 'chromaprint' 'taglib' 'kio' 'qt5-multimedia')
pkg_build_deps=('extra-cmake-modules' 'docbook-xsl' 'qt5-tools' 'kdoctools')
pkg_source=("https://sourceforge.net/projects/kid3/files/kid3/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('83f12a3336a200f86ce85b8126d9c0ad')

do_build() {
  mkdir -p build
  cd build
  
  cmake ../${pkg_name}-${pkg_version} \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DWITH_QT5=ON \
    -DWITH_APPS="CLI;KDE" \
    -DWITH_ID3LIB=OFF
  make 
}

do_package() {
  cd build
  
  make DESTDIR=${pkg_prefix} install
}
