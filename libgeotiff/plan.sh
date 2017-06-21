pkg_origin=cosmos

pkg_name=libgeotiff
pkg_version=1.4.2
pkg_description="TIFF based interchange format for georeferenced raster imagery"
pkg_license=('custom')
pkg_upstream_url="http://trac.osgeo.org/geotiff/"
pkg_deps=('libtiff' 'proj' 'libjpeg-turbo')
pkg_source=("http://download.osgeo.org/geotiff/libgeotiff/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('96ab80e0d4eff7820579957245d844f8')

do_build() {

    ./configure --prefix=/usr
    make
}

do_package() {
    make DESTDIR=${pkg_prefix} install
        
    install -D -m644 LICENSE ${pkg_prefix}/usr/share/licenses/libgeotiff/LICENSE
}
