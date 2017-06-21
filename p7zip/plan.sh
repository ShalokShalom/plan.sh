pkg_origin=cosmos

pkg_name=p7zip
pkg_version=16.02
pkg_description="A command-line port of the 7zip compression utility"
pkg_license=('GPL')
pkg_upstream_url="http://www.7-zip.org/"
pkg_deps=('gcc-libs' 'bash')
pkg_build_deps=('yasm' 'nasm')
pkg_source=("http://downloads.sourceforge.net/project/p7zip/p7zip/${pkg_version}/${pkg_name}_${pkg_version}_src_all.tar.bz2")
pkg_shasum=('a0128d661cfe7cc8c121e73519c54fbf')

do_build() {
        cp makefile.linux_amd64_asm makefile.machine

	make all3 OPTFLAGS="${CXXFLAGS}"
}

do_package() {

	make install \
		DEST_DIR=${pkg_prefix} \
		DEST_HOME="/usr" \
		DEST_MAN="/usr/share/man"

	install -d ${pkg_prefix}/usr/share/licenses/p7zip
	ln -s -t ${pkg_prefix}/usr/share/licenses/p7zip \
		/usr/share/doc/p7zip/DOCS/License.txt \
		/usr/share/doc/p7zip/DOCS/unRarLicense.txt
	
	chmod -R u+w,o+r ${pkg_prefix}/usr
}
