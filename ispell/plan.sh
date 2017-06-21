pkg_origin=cosmos

pkg_name=ispell
pkg_version=3.4.00
pkg_description="Fast screen-oriented spelling checker that shows you your errors in the context of the original file"
pkg_upstream_url="https://ficus-www.cs.ucla.edu/geoff/ispell.html"
pkg_license=('BSD')
pkg_deps=('ncurses')
pkg_source=("http://fmg-www.cs.ucla.edu/geoff/tars/${pkg_name}-${pkg_version}.tar.gz"
        'license.txt'
        'getline.patch')
pkg_shasum=('051c0946858e15797aed999b21276226'
         'bf51b6181b9914dedc266ba970bb7319'
         '1dca21c5d56405fe592175c3dde2fda2')

do_build() {
	#patch -p0 -i ${CACHE_PATH}/getline.patch

	sed -i -e 's/#undef USG/#define USG/' \
	       -e 's|/usr/local|/usr|' \
               -e 's|/lib|/lib/ispell|' local.h.linux
	cp local.h.linux local.h
	make TMPDIR=/tmp all
}

do_package() {

    install -dm755 ${pkg_prefix}/usr/{bin,lib/ispell,share/man/man{1,5}}

	for b in buildhash findaffix icombine ijoin ispell iwhich munchlist tryaffix; do
		install -m755 $b ${pkg_prefix}/usr/bin/
	done

	install -m644 languages/american/americanmed.hash \
	    ${pkg_prefix}/usr/lib/ispell/americanmed.hash
	install -m644 languages/english/english.aff \
	    ${pkg_prefix}/usr/lib/ispell/english.aff
	ln -s americanmed.hash ${pkg_prefix}/usr/lib/ispell/american.hash
	ln -s americanmed.hash ${pkg_prefix}/usr/lib/ispell/english.hash

	install -Dm644 ../license.txt  ${pkg_prefix}/usr/share/licenses/${pkg_name}/license.txt
}
