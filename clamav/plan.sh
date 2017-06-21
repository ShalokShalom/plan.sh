pkg_origin=

pkg_name=clamav
pkg_version=0.99.2
pkg_description='Anti-virus toolkit for Unix'
pkg_upstream_url='http://www.clamav.net/'
pkg_license=('GPL')
pkg_deps=('bzip2' 'zlib' 'libtool')
install="$pkg_name.install"
backup=('etc/logrotate.d/clamav')
pkg_source=("http://www.clamav.net/downloads/production/${pkg_name}-${pkg_version}.tar.gz"  
        'clamd.conf'
        'clamd.service'
        'freshclam.conf'
        'freshclamd.service'
        'logrotate'
        'tmpfiles.d')
pkg_shasum=('61b51a04619aeafd965892a53f86d192'
         '75584367b1fb2a335061afef95c07ba4'
         'ea0beeef854b4a3cf6b25dc49b228f56'
         '5c646ed6f7100c5223dab648c57d802a'
         '9ea7c696979f3977120791bdb355acf9'
         '8386e24561c5ce4cb87fa1d9f3b1cd87'
         '89ed33d37ca79d45b8c02418df2486e6')

do_build() {
	cd ${pkg_name}-${pkg_version}
	
	./configure --prefix=/usr \
	       --sysconfdir=/etc/clamav \
	       --with-dbdir=/var/lib/clamav \
	       --disable-clamav
	make
}

do_package() {
	cd ${pkg_name}-${pkg_version}
	make DESTDIR=${pkg_prefix} install

	install -Dm644 ../clamd.conf ${pkg_prefix}/etc/clamav/clamd.conf
	install -Dm644 ../freshclam.conf ${pkg_prefix}/etc/clamav/freshclam.conf
	install -Dm644 ../freshclamd.service ${pkg_prefix}/usr/lib/systemd/system/freshclamd.service
	install -Dm644 ../clamd.service ${pkg_prefix}/usr/lib/systemd/system/clamd.service
	install -Dm644 ../tmpfiles.d ${pkg_prefix}/usr/lib/tmpfiles.d/clamav.conf
	install -Dm644 ../logrotate ${pkg_prefix}/etc/logrotate.d/clamav
	install -d -o 64 -g 64 ${pkg_prefix}/run/clamav
	install -d -o 64 -g 64 ${pkg_prefix}/var/log/clamav
	install -d -o 64 -g 64 ${pkg_prefix}/var/lib/clamav
}
