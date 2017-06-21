pkg_origin=cosmos

pkgbase=antlr2
pkg_name=('antlr2' 'python2-antlr2')
pkg_version=2.7.7
pkg_upstream_url="http://www.antlr2.org/"
pkg_license=('custom')
pkg_build_deps=('java-environment' 'python2' 'sh')
pkg_source=("http://www.antlr2.org/download/antlr-${pkg_version}.tar.gz"
        'runantlr2.sh'
        'gcc4.4.patch')
pkg_shasum=('01cc9a2a454dd33dcd8c856ec89af090'
        'e4aa827cf78f97c4e5fae086831192d6'
        '8574c93f40e6477e83c29f9b07de49da')

do_build() {

  patch -p0 -i ${CACHE_PATH}/gcc4.4.patch

  ./configure --prefix=/usr \
    --disable-examples \
    --disable-csharp
  make
}

package_antlr2() {
  pkg_description="ANother Tool for Language Recognition, (formerly PCCTS) is a language tool that provides a framework for constructing recognizers, compilers, and translators from grammatical descriptions containing C++ or Java actions"
  pkg_deps=('sh')

  make prefix=${pkg_prefix}/usr install

  install -Dm644 ${CACHE_PATH}/antlr-${pkg_version}/antlr/antlr.jar \
    ${pkg_prefix}/usr/share/java/antlr2.jar
  install -Dm755 ${CACHE_PATH}/runantlr2.sh ${pkg_prefix}/usr/bin/runantlr2
  install -Dm644 ${CACHE_PATH}/antlr-${pkg_version}/LICENSE.txt \
    ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}

package_python2-antlr2() {
  pkg_description="ANother Tool for Language Recognition, (formerly PCCTS) is a language tool that provides a framework for constructing recognizers, compilers, and translators from grammatical descriptions containing C++ or Java actions (Python version)"
  pkg_deps=('antlr2' 'python2')

  python2 setup.py install --root=${pkg_prefix} --optimize=1
}
