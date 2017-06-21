pkg_origin=cosmos

pkg_name=python3-pytz
pkg_version=2017.2
pkg_description="Cross platform time zone library for Python"
pkg_upstream_url="https://pypi.python.org/pypi/pytz"
pkg_license=("MIT")
pkg_deps=('python3')
pkg_source=("https://pypi.python.org/packages/a4/09/c47e57fc9c7062b4e83b075d418800d322caa87ec0ac21e6308bd3a2d519/pytz-${pkg_version}.zip")
pkg_shasum=('f89bde8a811c8a1a5bac17eaaa94383c')

do_check() {

    python3 test_tzinfo.py
}

do_package() {

    python3 setup.py install --root=${CACHE_PATH}/

    install -D LICENSE.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
