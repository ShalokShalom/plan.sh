pkg_origin=

pkg_name=libpwquality
pkg_version=1.3.0
pkg_description="Library for password quality checking and generating random passwords"
pkg_upstream_url="https://github.com/libpwquality/libpwquality"
pkg_license=('GPL')
pkg_deps=('cracklib' 'python2')
pkg_source=("https://github.com/libpwquality/libpwquality/releases/download/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('2a3d4ba1d11b52b4f6a7f39622ebf736')

do_build() {
    cd ${pkg_name}-${pkg_version}

    ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var \
        --disable-static
    make
}

do_package() {
    cd ${pkg_name}-${pkg_version}

    make DESTDIR=${pkg_prefix} install
}
