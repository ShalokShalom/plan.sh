pkg_origin=cosmos

pkg_name=unixodbc
pkg_version=2.3.4
pkg_description="ODBC is an open specification for providing application developers with a predictable API with which to access Data Sources"
pkg_license=('GPL2' 'LGPL2.1')
pkg_upstream_url="http://www.unixodbc.org/"
backup=('etc/odbc.ini' 'etc/odbcinst.ini')
pkg_deps=('readline>=6.0' 'libtool')
pkg_source=("http://www.unixodbc.org/unixODBC-$pkg_version.tar.gz")
pkg_shasum=('bd25d261ca1808c947cb687e2034be81')

do_build() {
    cd unixODBC-${pkg_version}
    
    ./configure --prefix=/usr --sysconfdir=/etc
    make 
}

do_check() {
    cd unixODBC-${pkg_version}
    
    make -k check
}

do_package() {
    cd unixODBC-${pkg_version}
    
    make DESTDIR=${pkg_prefix} install 
}
