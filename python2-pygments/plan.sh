pkg_origin=cosmos

pkg_name=python2-pygments
pkg_version=2.2.0
pkg_description="Python syntax highlighter"
pkg_upstream_url="http://pygments.org/"
pkg_license=('BSD')
pkg_deps=('python2-setuptools')
pkg_source=("https://pypi.org/packages/source/P/Pygments/Pygments-${pkg_version}.tar.gz")
pkg_shasum=('13037baca42f16917cbd5ad2fab50844')

do_package() {
  python2 setup.py install --root=${CACHE_PATH} -O1

  install -Dm644 external/pygments.bashcomp ${CACHE_PATH}/etc/bash_completion.d/pygments
  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
