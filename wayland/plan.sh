pkg_origin=cosmos

pkg_name=wayland
pkg_version=1.13.0
pkg_description="Wayland the modern display server."
pkg_upstream_url="https://wayland.freedesktop.org"
pkg_license=('MIT')
pkg_deps=('libffi' 'expat')
#pkg_build_deps=('doxygen' 'xmlto') requires graphviz for documentation
pkg_source=("https://wayland.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('cae152ed956da6de53f9727bc1c45039')

do_build() {

	./configure --prefix=/usr \
        --disable-static \
        --disable-documentation
	make 
}

do_package() {
     make DESTDIR=${CACHE_PATH} install
     
     install -Dm 644 COPYING ${CACHE_PATH}/usr/share/licenses/${pkg_name}/COPYING
}
