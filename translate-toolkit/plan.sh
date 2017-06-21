pkg_origin=cosmos

pkg_name=translate-toolkit
pkg_version=2.1.0
pkg_description="Toolkit to convert between various different translation formats, help process and validate localisations"
pkg_upstream_url="http://toolkit.translatehouse.org/index.html"
pkg_license=('GPL')
pkg_deps=('bash' 'python2-lxml' 'python2-six')
pkg_build_deps=('python2-setuptools')
pkg_source=("https://github.com/translate/translate/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('302d20ad12a34da9992ef14f4ba13261')

do_package() {

  python2 -s setup.py install --root=${CACHE_PATH} --optimize=1
}
