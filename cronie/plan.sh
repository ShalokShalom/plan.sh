pkg_origin=cosmos

pkg_name=cronie
pkg_version=1.5.1
pkg_description='Daemon that runs specified programs at scheduled times and related tools'
pkg_upstream_url='https://fedorahosted.org/cronie/'
# should move soon to:
# https://pagure.io/cronie, now available at https://github.com/cronie-crond/cronie
pkg_license=('custom:BSD')
pkg_deps=('pam' 'bash' 'run-parts')
optpkg_deps=('pm-utils: defer anacron on battery power')
backup=('etc/anacrontab'
        'etc/conf.d/crond'
        'etc/pam.d/crond'
        'etc/cron.deny')
pkg_source=("https://github.com/cronie-crond/cronie/releases/download/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
        'cron.deny'
        'service'
        'pam.d')
pkg_shasum=('910e6effcc032998b0a49fbd46322e18'
         '2962d9812fbbbdee1bd7f1c1ccb5e372'
         'b4e1316eaa8f3806f20bad21a5101caa'
         'ace2584e5467371e35acf5f5af8f3c29')




do_build() {
	cd ${pkg_name}-${pkg_version}

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--enable-anacron \
		--with-inotify \
		--with-pam \

	make
}

do_package() {
	cd ${pkg_name}-${pkg_version}

	make DESTDIR=${pkg_prefix} install

	chmod u+s ${pkg_prefix}/usr/bin/crontab
	install -d ${pkg_prefix}/var/spool/{ana,}cron
	install -d ${pkg_prefix}/etc/cron.{d,hourly,daily,weekly,monthly}

	install -Dm644 ../pam.d ${pkg_prefix}/etc/pam.d/crond
	install -Dm644 ../cron.deny ${pkg_prefix}/etc/cron.deny
	install -Dm644 ../service ${pkg_prefix}/usr/lib/systemd/system/cronie.service

	install -Dm644 crond.sysconfig ${pkg_prefix}/etc/conf.d/crond
	install -Dm644 contrib/anacrontab ${pkg_prefix}/etc/anacrontab
	install -Dm644 contrib/0hourly ${pkg_prefix}/etc/cron.d/0hourly
	install -Dm755 contrib/0anacron ${pkg_prefix}/etc/cron.hourly/0anacron

	install -Dm644 COPYING ${pkg_prefix}/usr/share/licenses/cronie/COPYING
}
