pkg_origin=cosmos

pkg_name=python2-sphinx
pkg_version=1.6.2
pkg_description="Python documentation generator"
pkg_upstream_url="http://sphinx.pocoo.org/"
pkg_license=('GPL')
pkg_deps=('python2-setuptools' 'python2-pygments' 'python2-docutils' 'python2-jinja')
optpkg_deps=('texlive-latexextra: for generation of PDF documentation')
pkg_source=("https://files.pythonhosted.org/packages/source/S/Sphinx/Sphinx-${pkg_version}.tar.gz")
pkg_shasum=('a5f613e2b807c1f8c6cdd985a3d909f1')

do_package() {

    python2 setup.py install --root=${CACHE_PATH} -O1
}
