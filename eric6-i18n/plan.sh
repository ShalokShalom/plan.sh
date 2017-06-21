pkg_origin=

pkg_name=eric6-i18n
_pkgbase=eric6
pkg_version=16.11
pkg_description="i18n files for Eric6"
pkg_upstream_url="http://eric-ide.python-projects.org/"
pkg_license=('GPL3')
pkg_deps=('eric6')

pkg_source=("http://downloads.sourceforge.net/project/eric-ide/${_pkgbase}/stable/${pkg_version}/${pkg_name}-zh_CN-${pkg_version}.tar.gz"
        "http://downloads.sourceforge.net/project/eric-ide/${_pkgbase}/stable/${pkg_version}/${pkg_name}-tr-${pkg_version}.tar.gz"
        "http://downloads.sourceforge.net/project/eric-ide/${_pkgbase}/stable/${pkg_version}/${pkg_name}-ru-${pkg_version}.tar.gz"
        "http://downloads.sourceforge.net/project/eric-ide/${_pkgbase}/stable/${pkg_version}/${pkg_name}-pt-${pkg_version}.tar.gz"
        "http://downloads.sourceforge.net/project/eric-ide/${_pkgbase}/stable/${pkg_version}/${pkg_name}-it-${pkg_version}.tar.gz"
        "http://downloads.sourceforge.net/project/eric-ide/${_pkgbase}/stable/${pkg_version}/${pkg_name}-fr-${pkg_version}.tar.gz"
        "http://downloads.sourceforge.net/project/eric-ide/${_pkgbase}/stable/${pkg_version}/${pkg_name}-es-${pkg_version}.tar.gz"
        "http://downloads.sourceforge.net/project/eric-ide/${_pkgbase}/stable/${pkg_version}/${pkg_name}-en-${pkg_version}.tar.gz"
        "http://downloads.sourceforge.net/project/eric-ide/${_pkgbase}/stable/${pkg_version}/${pkg_name}-de-${pkg_version}.tar.gz"
        "http://downloads.sourceforge.net/project/eric-ide/${_pkgbase}/stable/${pkg_version}/${pkg_name}-cs-${pkg_version}.tar.gz")
pkg_shasum=('a140d32b884ffc465fee16328b205554'
         '29451f1ab68a8f36c301d5f8190bbf6c'
         '37116a56cc6b9a091ab758fa2efb2a95'
         '48cc779bffeaa4d37d84617b6224af98'
         '0829eb08860674e7f0381ab094a7e441'
         'e34ae63a033558299b1c030d49a3189f'
         '263f54f8669ca5f44bd73a3449b43249'
         '26b6dafd0935ffbfcf8d1c5563ab1e4f'
         '448c96fe4b4947eb483949a8c18bdcd2'
         '4d6196b7ce3226baceb6e47bdc8efd41')

do_package() {
  cd ${_pkgbase}-${pkg_version}/eric/i18n

  install -d ${pkg_prefix}/usr/lib/python3.5/site-packages/${_pkgbase}/i18n
  install *.qm ${pkg_prefix}/usr/lib/python3.5/site-packages/${_pkgbase}/i18n/
}
