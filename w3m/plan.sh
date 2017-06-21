pkg_origin=

pkg_name=w3m
pkg_version=0.5.3.2
_commit=1ac245bdcd803f69c7793ecccc090a80b1137d35
pkg_description="Pager that can be used as a text-mode WWW browser."
pkg_upstream_url="http://w3m.sourceforge.net/"
pkg_license=('custom')
pkg_deps=('openssl' 'gc' 'ncurses' 'zlib')
pkg_build_deps=('imlib2')
optpkg_deps=('imlib2: for graphics support') 
pkg_source=("https://github.com/tats/w3m/archive/${_commit}.zip")
pkg_shasum=('b9240a9a0fac52e378b7319897c0fd97')

do_build() {
	cd ${pkg_name}-${_commit}

	./configure \
        --prefix=/usr \
        --libexecdir=/usr/lib \
        --disable-image \
        --with-imagelib=imlib2 \
        --with-termlib=ncurses \
        --disable-w3mmailer \
        --disable-mouse 
    make
}

do_package() {
	cd ${pkg_name}-${_commit}
	make DESTDIR=${pkg_prefix} install

	install -d ${pkg_prefix}/usr/share/{doc,licenses}/${pkg_name}
	find doc/* | grep -v CVS | xargs -i install -m644 "{}" ${pkg_prefix}/usr/share/doc/${pkg_name}
	ln -s ../../doc/${pkg_name}/README ${pkg_prefix}/usr/share/licenses/${pkg_name}
}
