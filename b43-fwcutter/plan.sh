pkg_origin=cosmos

pkg_name=b43-fwcutter
pkg_version=019
pkg_description="firmware extractor for the bcm43xx kernel module"
pkg_upstream_url="http://wireless.kernel.org/en/users/Drivers/b43"
pkg_deps=('glibc')
pkg_license=('GPL')
pkg_source=("http://bues.ch/b43/fwcutter/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('19d1f4226a625756726bdf7ed5dc2a0a')

do_build() {
    cd ${pkg_name}-${pkg_version}

    make
}

do_package() {
    cd ${pkg_name}-${pkg_version}

    install -D -m755 b43-fwcutter ${pkg_prefix}/usr/bin/b43-fwcutter
    install -D -m644 b43-fwcutter.1 ${pkg_prefix}/usr/share/man/man1/b43-fwcutter.1
}

