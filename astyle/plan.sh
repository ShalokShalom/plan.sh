pkg_origin=cosmos

pkg_name=astyle
pkg_version=3.0
_pkg_version=3.0.0
pkg_description="Artistic Style is a source code indenter, formatter, and beautifier for the C, C++, C# and Java programming languages."
pkg_upstream_url="http://astyle.sourceforge.net/ "
pkg_license=('LGPL')
pkg_source=("http://downloads.sourceforge.net/sourceforge/astyle/${pkg_name}_${pkg_version}_linux.tar.gz")
pkg_shasum=('c89f76229e6cf8c56df6b74aef9ed0bd')

do_build() {
  
  make release shared
}

do_package() {
  install -D -m755 -o root -g root astyle ${pkg_prefix}/usr/bin/astyle
  install -Dm0755 libastyle.so.${_pkg_version} ${pkg_prefix}/usr/lib/libastyle.so

  for files in `find ${CACHE_PATH}/${pkg_name}/doc -name *.html`
	do
	    mkdir -p ${pkg_prefix}/usr/share/astyle
	    cp $files ${pkg_prefix}/usr/share/astyle
	done

  for files in `find ${CACHE_PATH}/${pkg_name}/doc -name *.css`
	do
	    mkdir -p ${pkg_prefix}/usr/share/astyle
	    cp $files ${pkg_prefix}/usr/share/astyle
	done
}
