pkg_origin=cosmos

pkg_name=libepoxy
pkg_version=1.4.3
_pkg_version=1.4
pkg_description="Library for handling OpenGL function pointer management for you"
pkg_upstream_url="https://github.com/anholt/libepoxy"
pkg_license=('MIT')
pkg_deps=('glibc')
pkg_build_deps=('xorg-util-macros' 'python3' 'libgl' 'meson' 'ninja')
pkg_source=("https://github.com/anholt/libepoxy/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('af4c3ce0fb1143bdc4e43f85695a9bed')

do_build() {
    mkdir -p build

    meson ../${pkg_name}-${pkg_version} \
        --prefix=/usr \
        --buildtype=release
    ninja
}

check() {

    mesontest
}

do_package() {
    DESTDIR=${pkg_prefix} ninja install

    install -Dm644 ../${pkg_name}-${pkg_version}/COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/COPYING
}
