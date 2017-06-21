pkg_origin=cosmos

pkg_name=libvpx
pkg_version=1.6.1
pkg_description="The VP8 Codec SDK"
pkg_upstream_url="http://www.webmproject.org/"
pkg_license=('BSD')
pkg_deps=('glibc')
pkg_build_deps=('yasm')
pkg_source=("https://github.com/webmproject/libvpx/archive/v${pkg_version}.tar.gz")
#pkg_source=("http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-${pkg_version}.tar.bz2")
pkg_shasum=('b0925c8266e2859311860db5d76d1671')

do_build() {

    ./configure --prefix=/usr \
        --enable-vp8 \
        --enable-vp9 \
        --enable-runtime-cpu-detect \
        --enable-shared \
        --enable-postproc \
        --enable-pic \
        --disable-install-docs \
        --disable-install-srcs \
        --enable-experimental \
        --enable-spatial-svc
    make
}

do_package() {
    make DIST_DIR=${pkg_prefix}/usr install
    
    #chmod -R o+r "${pkg_prefix}/usr/include/vpx"
    install -D -m 0644 LICENSE ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
