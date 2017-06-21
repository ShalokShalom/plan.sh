pkg_origin=

# include global config
source ../_buildscripts/${current_repo}-${_arch}-cfg.conf

pkg_name=kde-common
pkg_version=${_kdever}
pkg_description="KDE Common Configuration Files, Scripts and Artwork"
pkg_upstream_url="http://www.kde.org"
pkg_license=('GPL')
pkg_deps=('qt5-base' 'pinentry' 'openssh' 'bash' 'xclip' 'kdialog')
pkg_source=("https://dl.opendesktop.org/api/files/download/id/1485341541/rootactions_servicemenu_2.9.1.tar.gz"
        'CopyPath.desktop'
	#"http://www.kde-apps.org/CONTENT/content-files/102825-compressattach.desktop.bz2"
	'servicemenu-rootactions.patch'
	'sysinfo.sh'
	'agent-startup.sh'
	'agent-shutdown.sh'
	'skype.desktop'
	'md5sha1calc.sh'
	'md5sha1calc.desktop'
	'bak.desktop'
	'bak-restore.desktop'
	'checkiso.sh'
	'checkiso.desktop'
	'org.freedesktop.blkid.policy'
	'org.freedesktop.head.policy'
	"https://dl.opendesktop.org/api/files/download/id/1463155225/176001-kompare_servicemenu.desktop")
  
pkg_shasum=('44769ab05560bb1ba5a69a30be8b1c92'
         '091595cec9e9e4222daedee71c01bc70'
         #'630ffe7118eef8608a9e5e393a0b1e12'
         'e815fcdba963a79cd39989182df1a994'
         'cdb4a289c5cfbf55590327ced615e57a'
         '2c479e69c92e7f6a1dd9cfb03ed8ee4f'
         '18e8d01124b19f7df2937c06e177bf7f'
         '543432fa49677efd496ac2ab15ad46e7'
         'ac56df816efbbb853e21d70a3d62bb4d'
         '9015a113e6308800bb0704f1f8b4de75'
         '3c76971c70e339907f7b1439de4d2413'
         '68915128538c8a5db6f1f55d328d824e'
         '42bdb0589fe39d62970267e1f905454e'
         '9bb1c9c96d03286ae27bc0c3c624af01'
         '453e083b8ef8164c1810275046dd7c81'
         'e97a9f4b8f70462b88ad166909e4122d'
         'a8a51d833d9207f5a497638c1f43dd35')

do_package() {
	# install scripts for gpg/ssh-agent
	install -D -m 755 -o root -g root $CACHE_PATH/agent-startup.sh $pkg_prefix/etc/xdg/plasma-workspace/env/agent-startup.sh
	install -D -m 755 -o root -g root $CACHE_PATH/agent-shutdown.sh $pkg_prefix/etc/xdg/plasma-workspace/shutdown/agent-shutdown.sh
	
	# install sysinfo script
	install -D -m755 -o root -g root ${CACHE_PATH}/sysinfo.sh ${pkg_prefix}/usr/bin/sysinfo

	# install root actions service menu
	cd ${CACHE_PATH}/rootactions_servicemenu_2.9.1/Root_Actions_2.9.1/dolphin-KDE4/
	mkdir -p ${pkg_prefix}/usr/share/kservices5/ServiceMenus/
	install -m755 *.desktop ${pkg_prefix}/usr/share/kservices5/ServiceMenus/
	
    cd ${CACHE_PATH}/rootactions_servicemenu_2.9.1/Root_Actions_2.9.1
    patch -p2 < ${CACHE_PATH}/servicemenu-rootactions.patch      
	install -Dm755 rootactions-servicemenu.pl ${pkg_prefix}/usr/bin/rootactions-servicemenu.pl
        sed "s|Icon=terminal|Icon=utilities-terminal|g" -i ${pkg_prefix}/usr/share/kservices5/ServiceMenus/10-rootactionsfolders.desktop
        sed "s|Icon=terminal|Icon=utilities-terminal|g" -i ${pkg_prefix}/usr/share/kservices5/ServiceMenus/11-rootactionsfiles.desktop
        
    cd ${CACHE_PATH}/rootactions_servicemenu_2.9.1/Root_Actions_2.9.1/krusader-KDE4/
    install -Dm644 krusader_rootactions.xml ${pkg_prefix}/usr/share/krusader/krusader_rootactions.xml
 
	# install all other service menus
	install -m755 ${CACHE_PATH}/CopyPath.desktop ${pkg_prefix}/usr/share/kservices5/ServiceMenus/CopyPath.desktop
	install -m755 ${CACHE_PATH}/bak.desktop ${pkg_prefix}/usr/share/kservices5/ServiceMenus/bak.desktop
	install -m755 ${CACHE_PATH}/bak-restore.desktop ${pkg_prefix}/usr/share/kservices5/ServiceMenus/bak-restore.desktop

	#install -m755 ${CACHE_PATH}/102825-compressattach.desktop ${pkg_prefix}/usr/share/kservices5/ServiceMenus/compress-attach.desktop
        #sed "s~Icon=attach~Icon=mail-attachment~g" -i ${pkg_prefix}/usr/share/kservices5/ServiceMenus/compress-attach.desktop
	
	# install menu entries
	cd ${CACHE_PATH}
	#install -m755 -d ${pkg_prefix}/usr/share/desktop-directories
	install -m755 -d ${pkg_prefix}/usr/share/applications
	install -m755 ${CACHE_PATH}/skype.desktop ${pkg_prefix}/usr/share/applications/skype.desktop
	
	# install md5sha1calc
	install -D -m755 md5sha1calc.sh ${pkg_prefix}/usr/bin/md5sha1calc
	install -D -m644 md5sha1calc.desktop ${pkg_prefix}/usr/share/kservices5/ServiceMenus/md5sha1calc.desktop
	
	# install kompare desktop
	install -D -m644 176001-kompare_servicemenu.desktop ${pkg_prefix}/usr/share/kservices5/ServiceMenus/kompare_servicemenu.desktop
	
	# install checkiso
	install -D -m755 checkiso.sh ${pkg_prefix}/usr/bin/checkiso
	install -D -m644 checkiso.desktop ${pkg_prefix}/usr/share/kservices5/ServiceMenus/checkiso.desktop
	install -D -m755 org.freedesktop.blkid.policy ${pkg_prefix}/usr/bin/org.freedesktop.blkid.policy
	install -D -m755 org.freedesktop.head.policy ${pkg_prefix}/usr/bin/org.freedesktop.head.policy
}
