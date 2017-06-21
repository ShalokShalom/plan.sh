pkg_origin=cosmos

pkg_name=mime-types
pkg_version=9
pkg_description='Provides /etc/mime.types'
pkg_upstream_url='http://www.gentoo.org/'
pkg_license=('GPL2')
backup=('etc/mime.types')
pkg_source=("http://mirrors.kernel.org/gentoo/distfiles/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('75c88966b6516cf085125072dc8b39e5')

do_package() {

    install -Dm644 mime.types ${pkg_prefix}/etc/mime.types
}
