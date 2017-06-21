pkg_origin=

pkg_name=phpmyadmin
pkg_version=4.7.1
pkg_description='PHP and hence web-based tool to administrate MySQL over the WWW'
pkg_upstream_url='https://www.phpmyadmin.net'
pkg_license=('GPL')
pkg_deps=('mariadb-clients' 'php')
backup=(etc/webapps/phpmyadmin/config.inc.php)
pkg_source=("https://files.phpmyadmin.net/phpMyAdmin/${pkg_version}/phpMyAdmin-${pkg_version}-all-languages.zip")
pkg_shasum=('79765937333d22d37b58bfa74b73d262')

do_package() {
  _instdir=${pkg_prefix}/usr/share/webapps/phpMyAdmin
  mkdir -p ${_instdir} ${pkg_prefix}/etc/webapps/phpmyadmin
  cd ${_instdir}

  cp -ra "$CACHE_PATH"/phpMyAdmin-$pkg_version-all-languages/* .

  ln -s /etc/webapps/phpmyadmin/config.inc.php ${_instdir}/config.inc.php
  cp ${_instdir}/config.sample.inc.php ${pkg_prefix}/etc/webapps/phpmyadmin/config.inc.php

  cat >${pkg_prefix}/etc/webapps/phpmyadmin/apache.example.conf <<EOF
	Alias /phpmyadmin "/usr/share/webapps/phpMyAdmin"
	<Directory "/usr/share/webapps/phpMyAdmin">
		AllowOverride All
		Options FollowSymlinks
		Order allow,deny
		Allow from all
		php_admin_value open_basedir "/srv/:/tmp/:/usr/share/webapps/:/etc/webapps:/usr/share/pear/"
	</Directory>
EOF
}
