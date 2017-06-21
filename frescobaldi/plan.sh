pkg_origin=

pkg_name=frescobaldi
pkg_version=3.0.0
_commit=ef771c03f858693fdb7bc62e4a8ded61535b1cbf
pkg_description="A LilyPond sheet music editor. It aims to be powerful, yet lightweight and easy to use."
pkg_upstream_url="http://www.frescobaldi.org/"
pkg_license=("GPL")
pkg_deps=('lilypond' 'python3-poppler-qt' 'pyqt5-python3' 'python3-ly')
optpkg_deps=('lilypond-doc')
pkg_build_deps=('cmake' 'docbook-xsl' 'python3')
pkg_source=("https://github.com/wbsoft/frescobaldi/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
#pkg_source=("https://github.com/wbsoft/frescobaldi/archive/${_commit}.zip")
pkg_shasum=('dacc4cc23e4de5acef163001d18dfa8c')

do_prepare() {
    cd ${pkg_name}-${pkg_version}
    #Prevent windows script to execute
    #sed -i '1,4d' setup.cfg
}

do_package() {
    cd ${pkg_name}-${pkg_version}
    python3 setup.py install --root=${pkg_prefix}/ --optimize=1

    find ${pkg_prefix} -name '*.py' -exec sed -i -e 's/^#!\/usr\/bin\/env python$/#!\/usr\/bin\/env python3/' \
                                             -e 's/^#!\/usr\/bin\/python$/#!\/usr\/bin\/python3/' {} \;
}
