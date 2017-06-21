pkg_origin=cosmos
 
pkg_name=libuv
pkg_version=1.12.0
pkg_description="Multi-platform support library with a focus on asynchronous I/O"
pkg_upstream_url="https://github.com/libuv/libuv"
pkg_license=('custom')
pkg_deps=('glibc')
pkg_source=("https://github.com/libuv/libuv/archive/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('f1a89e5c26ba3b378a49e6c37ebfa708')

do_build() {
    
    ./autogen.sh
    ./configure --prefix=/usr
    make
}

do_package() {
    make DESTDIR=${pkg_prefix} install
    
    install -Dm644 LICENSE ${pkg_prefix}/usr/share/licenses/$pkg_name/LICENSE
}
