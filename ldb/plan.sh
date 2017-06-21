pkg_origin=cosmos

pkg_name=ldb
pkg_version=1.1.30
pkg_description="Provide a fast database with an LDAP-like API designed to be used within an application."
pkg_upstream_url="http://ldb.samba.org/"
pkg_license=('GPL3')
pkg_deps=('talloc' 'tevent' 'tdb' 'popt' 'python2')
pkg_source=("https://samba.org/ftp/ldb/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('74881f1fb5704b02abfb93ee7aae8e69')

do_build() {

	./configure --prefix=/usr \
        --disable-rpath \
        --disable-rpath-install \
        --bundled-libraries=cmocka \
        --builtin-libraries=replace \
        --with-modulesdir=/usr/lib/ldb/modules \
        --with-privatelibdir=/usr/lib/ldb
	make
}

do_package() {

	make DESTDIR=${pkg_prefix}/ install
}

