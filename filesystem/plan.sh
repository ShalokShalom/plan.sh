pkg_origin=cosmos

pkg_name=filesystem
pkg_version=2017.01
_codename=2017
pkg_description='Base filesystem'
pkg_license=('GPL')
pkg_upstream_url='https://kaosx.us'
install='filesystem.install'
pkg_deps=('iana-etc' 'bash' 'coreutils')
pkg_build_deps=('asciidoc')
backup=('etc/fstab' 'etc/crypttab' 'etc/group' 'etc/hosts' 'etc/ld.so.conf' 'etc/passwd'
        'etc/shadow' 'etc/gshadow' 'etc/resolv.conf' 'etc/motd' 'etc/nsswitch.conf'
        'etc/shells' 'etc/host.conf' 'etc/securetty' 'etc/profile' 'etc/issue' 'etc/hostname'
        'etc/machine-info' 'etc/vconsole.conf')
pkg_source=('group' 'issue' 'nsswitch.conf' 'securetty' 'host.conf' 'ld.so.conf'
        'passwd' 'shadow' 'fstab' 'crypttab' 'hosts' 'hostname' 'motd' 'resolv.conf' 'shells'
        'gshadow' 'profile' 'machine-info' 'os-release'
        'vconsole.conf' 'locale.sh')
pkg_shasum=('1109716df48ad1bfbf08520ea12fe347'
         'db5338e17b20e85deaf85a16d30f5d65'
         'f3cad1dd5ccc7b1bab3e8deb0cd1b42d'
         '4c4540eeb748bf1f71d631b8c1dcf0b3'
         'f28150d4c0b22a017be51b9f7f9977ed'
         '6e488ffecc8ba142c0cf7e2d7aeb832e'
         'b259783e9fee2368fe632a8258fdc80f'
         '1ec1b16e2a71fad63ab8f147069a5d97'
         'ca716f853860199c1286e7939b2f2666'
         'f477860ae71b9efce9aadf7dfdfec9f3'
         '7bc65f234dfb6abf24e7c3b03e86f4ff'
         'b7244a8455581eeb441edeec03495054'
         'd41d8cd98f00b204e9800998ecf8427e'
         '6f48288b6fcaf0065fcb7b0e525413e0'
         '22518e922891f9359f971f4f5b4e793c'
         '09bce9236c3729d31aaa528bcf5d198e'
         'f3b6ae7db8adffaaa4bffc6099dcbd50'
         '13d8d253ae8613ba2474683f585e73db'
         'd8fbe3db0dfc9b3da18e72d245ea0d66'
         '201bbb8b4734d2f46afe1e24d7cc6173'
         '08565c934ec0d6b90da1165ee9cf82dc')

do_package() {
	cd ${pkg_prefix}

	#
	# setup root filesystem
	#
	for d in boot dev etc home media mnt usr var opt srv/http run; do
		install -d -m755 ${d}
	done
	install -d -m555 proc
	install -d -m555 sys
	install -d -m0750 root
	install -d -m1777 tmp
	# vsftpd won't run with write perms on /srv/ftp
	install -d -m555 -g ftp srv/ftp

	# setup /etc
	install -d etc/{ld.so.conf.d,skel,profile.d}
	for f in fstab group host.conf hostname hosts issue ld.so.conf motd nsswitch.conf passwd resolv.conf securetty shells profile machine-info os-release vconsole.conf; do
		install -m644 ${CACHE_PATH}/${f} etc/
	done
	ln -s /proc/self/mounts etc/mtab
	for f in gshadow shadow crypttab; do
		install -m600 ${CACHE_PATH}/${f} etc/
	done
	touch etc/KaOS-release
	install -m755 ${CACHE_PATH}/locale.sh etc/profile.d/locale.sh

	# setup /var
	for d in cache/man local opt log/old lib/misc empty; do
		install -d -m755 var/${d}
	done
	install -d -m1777 var/{tmp,spool/mail}
	# allow setgid games to write scores
	install -d -m775 -g games var/games
	ln -s spool/mail var/mail
	ln -s ../run var/run
	ln -s ../run/lock var/lock

	#
	# setup /usr hierarchy
	#
	for d in bin include lib sbin share/misc src; do
		install -d -m755 usr/${d}
	done
	for d in $(seq 8); do
		install -d -m755 usr/share/man/man${d}
	done


	#
	# setup /usr/local hierarchy
	#
	for d in bin etc games include lib man sbin share src; do
		install -d -m755 usr/local/${d}
	done
	ln -s ../man usr/local/share/man
}

