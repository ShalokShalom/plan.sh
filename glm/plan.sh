pkg_origin=cosmos

pkg_name=glm
pkg_version=0.9.8.4
pkg_description="Header only C++ mathematics library for graphics software based on the OpenGL Shading Language (GLSL) specifications"
pkg_license=('MIT')
pkg_upstream_url="http://glm.g-truc.net"
pkg_source=("https://github.com/g-truc/glm/releases/download/${pkg_version}/glm-${pkg_version}.zip")
pkg_shasum=('84a5b85fcfa9c105f4551d9b29cc80b3')

do_build() {
  mkdir -p build
  
  cmake ../${pkg_name} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/glm
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ../glm/copying.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

