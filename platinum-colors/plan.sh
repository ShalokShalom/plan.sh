pkg_origin=

pkg_name=platinum-colors
pkg_version=1.0
pkg_description="Platinum colors scheme"
pkg_upstream_url=("http://opendesktop.org/content/show.php?content=115107")
pkg_license=('Artistic 2.0')
pkg_deps=('kde-workspace')
pkg_source=('platinum.colors')
pkg_shasum=('26c51923c8a24db762af6c4b77ec72ef')

do_package() {
       mkdir -p $pkg_prefix/usr/share/apps/color-schemes
       chmod 755 -R $pkg_prefix/usr/share/apps/color-schemes

       cd ${CACHE_PATH}
       cp platinum.colors $pkg_prefix/usr/share/apps/color-schemes/platinum.colors
}
