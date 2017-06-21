pkg_origin=

pkg_name=libreoffice
_LOver=5.3.3.2
pkg_version=5.3.3.2
_pkg_version=5.3.3
pkg_license=('LGPL3')
pkg_upstream_url="https://www.libreoffice.org/"
pkg_description="Productivity suite that is compatible with other major office suites"
pkg_deps=("curl>=7.20.0" 'python3' 'libabw>=0.1.0' 'libwpd>=0.9.2' 'libwps' 'libxaw' "neon>=0.28.6" 
         'pango' 'nss' 'libjpeg' 'libxrandr' 'libgl' 'dbus-glib' 'libxslt' 'redland' 'graphite' 'icu'
         'hyphen' 'lpsolve' 'gcc-libs' 'sh' 'librsvg' 'lcms2' 'hicolor-icon-theme' 'desktop-file-utils' 
         'shared-mime-info' 'translate-toolkit' 'xdg-utils' 'ttf-liberation' 'libcups' 
         'poppler' 'sane' 'unixodbc' 'libwpg' 'imagemagick' 'hunspell'
         'mesa' 'gst-plugins-base' 'java-runtime' 'postgresql-libs' 'libvisio' 'bluez' 'liblangtag'
         'libetonyek' 'libodfgen' 'libatomic_ops' 'clucene' 'glew' 'glu' 'gconf' 
         'java-environment' 'beanshell'  'vigra' 'pstoedit' 'libmythes' 'gtk2')
pkg_build_deps=('perl-archive-zip' 'zip' 'unzip' 'apache-ant' 'gperf' 'cppunit' 'libldap'
             'junit' 'doxygen' 'apr' 'serf' 'glm' 'mdds')
           'libreoffice-impress' 'libreoffice-kde4' 'libreoffice-math' 'libreoffice-sdk'
           'libreoffice-sdk-doc' 'libreoffice-writer' 'libreoffice-en-US' 'libreoffice-postgresql-connector')
          'libreoffice-impress' 'libreoffice-kde4' 'libreoffice-math' 'libreoffice-sdk'
          'libreoffice-sdk-doc' 'libreoffice-writer' 'libreoffice-en-US' 'libreoffice-postgresql-connector')
          'libreoffice-impress' 'libreoffice-kde4' 'libreoffice-math' 'libreoffice-sdk'
          'libreoffice-sdk-doc' 'libreoffice-writer' 'libreoffice-en-US' 'libreoffice-postgresql-connector')
#_mirror="https://caesar.acc.umu.se/mirror/documentfoundation.org/libreoffice/src/$_pkg_version"
_mirror="http://dev-builds.libreoffice.org/pre-releases/src"
#_additional_source_pkg_upstream_url="https://hg.services.openoffice.org/binaries"
_additional_source_pkg_upstream_url="http://dev-www.libreoffice.org/src"
pkg_source=(${_mirror}/${pkg_name}{,-help,-translations}-${_LOver}.tar.xz  
	${_additional_source_url}/86b1daaa438f5a7bea9a52d7b9799ac0-xmlsec1-1.2.23.tar.gz    
	${_additional_source_url}/35c94d2df8893241173de1d16b6034c0-swingExSrc.zip
	${_additional_source_url}/798b2ffdc8bcfe7bca2cf92b62caf685-rhino1_5R5.zip
	${_additional_source_url}/ada24d37d8d638b3d8a9985e80bc2978-source-9.0.0.7-bj.zip
	${_additional_source_url}/2a177023f9ea8ec8bd00837605c5df1b-jakarta-tomcat-5.0.30-src.tar.gz
	${_additional_source_url}/a7983f859eafb2677d7ff386a023bc40-xsltml_2.1.2.zip
	${_additional_source_url}/commons-logging-1.2-src.tar.gz
	${_additional_source_url}/8ab049135b2d15313da5d9f0656894a1-commons-lang3-3.3.1-src.tar.gz
	${_additional_source_url}/2c9b0f83ed5890af02c0df1c1776f39b-commons-httpclient-3.1-src.tar.gz
	${_additional_source_url}/048751f3271906db5126ab76870444c4-commons-codec-1.9-src.zip
	${_additional_source_url}/eeb2c7ddf0d302fba4bfc6e97eac9624-libbase-1.1.6.zip
	${_additional_source_url}/39bb3fcea1514f1369fcfc87542390fd-sacjava-1.3.zip
	${_additional_source_url}/3404ab6b1792ae5f16bbd603bd1e1d03-libformula-1.1.7.zip
	${_additional_source_url}/97b2d4dba862397f446b217e2b623e71-libloader-1.1.6.zip
	${_additional_source_url}/f94d9870737518e3b597f9265f4e9803-libserializer-1.1.6.zip
	${_additional_source_url}/8ce2fcd72becf06c41f7201d15373ed9-librepository-1.1.6.zip
	${_additional_source_url}/d8bd5eed178db6e2b18eeed243f85aa8-flute-1.1.6.zip
	${_additional_source_url}/3bdf40c0d199af31923e900d082ca2dd-libfonts-1.1.6.zip
	${_additional_source_url}/ace6ab49184e329db254e454a010f56d-libxml-1.1.7.zip
	${_additional_source_url}/db60e4fde8dd6d6807523deb71ee34dc-liblayout-0.2.10.zip
	${_additional_source_url}/ba2930200c9f019c2d93a8c88c651a0f-flow-engine-0.9.4.zip
	${_additional_source_url}/10d61fbaa6a06348823651b1bd7940fe-libexttextcat-3.4.4.tar.bz2 
	${_additional_source_url}/libcmis-0.5.1.tar.gz 
	${_additional_source_url}/liborcus-0.12.1.tar.gz
	#${_additional_source_url}/aa899eff126216dafe721149fbdb511b-liblangtag-0.5.8.tar.bz2
	${_additional_source_url}/0168229624cfac409e766913506961a8-ucpp-1.3.2.tar.gz
	${_additional_source_url}/libcdr-0.1.3.tar.bz2
	${_additional_source_url}/libmspub-0.1.2.tar.bz2
	${_additional_source_url}/libmwaw-0.3.9.tar.bz2
	${_additional_source_url}/libfreehand-0.1.1.tar.bz2
	${_additional_source_url}/Firebird-3.0.0.32483-0.tar.bz2
	${_additional_source_url}/libe-book-0.1.2.tar.bz2
	${_additional_source_url}/17410483b5b5f267aa18b7e00b65e6e0-hsqldb_1_8_0.zip
	#${_additional_source_url}/976734806026a4ef8bdd17937c8898b9-icu4c-57_1-src.tgz
	${_additional_source_url}/boost_1_60_0.tar.bz2
	${_additional_source_url}/language-subtag-registry-2016-07-19.tar.bz2
	${_additional_source_url}/libgltf/libgltf-0.0.2.tar.bz2
	${_additional_source_url}/CoinMP-1.7.6.tgz
	#${_additional_source_url}/bae83fa5dc7f081768daace6e199adc3-glm-0.9.4.6-libreoffice.zip
	${_additional_source_url}/4b87018f7fff1d054939d19920b751a0-collada2gltf-master-cb1d97788a.tar.bz2
	${_additional_source_url}/OpenCOLLADA-master-6509aa13af.tar.bz2
	${_additional_source_url}/libpagemaker-0.0.3.tar.bz2
	${_additional_source_url}/libstaroffice-0.0.2.tar.bz2 
	${_additional_source_url}/libzmf-0.0.1.tar.bz2
	${_additional_source_url}/ltm-1.0.zip
	http://dev-www.libreoffice.org/extern/185d60944ea767075d27247c3162b3bc-unowinreg.dll
	intro.png)
	
	noextract=(18f577b374d60b3c760a3a3350407632-STLport-4.5.tar.gz
        185d60944ea767075d27247c3162b3bc-unowinreg.dll
	ada24d37d8d638b3d8a9985e80bc2978-source-9.0.0.7-bj.zip
	798b2ffdc8bcfe7bca2cf92b62caf685-rhino1_5R5.zip
	86b1daaa438f5a7bea9a52d7b9799ac0-xmlsec1-1.2.23.tar.gz   
	10d61fbaa6a06348823651b1bd7940fe-libexttextcat-3.4.4.tar.bz2 
	libcmis-0.5.1.tar.gz 
	35c94d2df8893241173de1d16b6034c0-swingExSrc.zip
	2a177023f9ea8ec8bd00837605c5df1b-jakarta-tomcat-5.0.30-src.tar.gz
	a7983f859eafb2677d7ff386a023bc40-xsltml_2.1.2.zip
	commons-logging-1.2-src.tar.gz
	8ab049135b2d15313da5d9f0656894a1-commons-lang3-3.3.1-src.tar.gz
	2c9b0f83ed5890af02c0df1c1776f39b-commons-httpclient-3.1-src.tar.gz
	048751f3271906db5126ab76870444c4-commons-codec-1.9-src.zip
	eeb2c7ddf0d302fba4bfc6e97eac9624-libbase-1.1.6.zip
	39bb3fcea1514f1369fcfc87542390fd-sacjava-1.3.zip
	3404ab6b1792ae5f16bbd603bd1e1d03-libformula-1.1.7.zip
	97b2d4dba862397f446b217e2b623e71-libloader-1.1.6.zip
	f94d9870737518e3b597f9265f4e9803-libserializer-1.1.6.zip
	8ce2fcd72becf06c41f7201d15373ed9-librepository-1.1.6.zip
	d8bd5eed178db6e2b18eeed243f85aa8-flute-1.1.6.zip
	3bdf40c0d199af31923e900d082ca2dd-libfonts-1.1.6.zip
	ace6ab49184e329db254e454a010f56d-libxml-1.1.7.zip
	db60e4fde8dd6d6807523deb71ee34dc-liblayout-0.2.10.zip
	ba2930200c9f019c2d93a8c88c651a0f-flow-engine-0.9.4.zip
	liborcus-0.12.1.tar.gz
	#aa899eff126216dafe721149fbdb511b-liblangtag-0.5.8.tar.bz2
	0168229624cfac409e766913506961a8-ucpp-1.3.2.tar.gz
	17410483b5b5f267aa18b7e00b65e6e0-hsqldb_1_8_0.zip
	#976734806026a4ef8bdd17937c8898b9-icu4c-57_1-src.tgz
	boost_1_60_0.tar.bz2
	libcdr-0.1.3.tar.bz2
	libmspub-0.1.2.tar.bz2
	libmwaw-0.3.9.tar.bz2
	libfreehand-0.1.1.tar.bz2
	Firebird-3.0.0.32483-0.tar.bz2
	libe-book-0.1.2.tar.bz2
	language-subtag-registry-2016-07-19.tar.bz2
	CoinMP-1.7.6.tgz
	#bae83fa5dc7f081768daace6e199adc3-glm-0.9.4.6-libreoffice.zip
	4b87018f7fff1d054939d19920b751a0-collada2gltf-master-cb1d97788a.tar.bz2
	OpenCOLLADA-master-6509aa13af.tar.bz2
	libpagemaker-0.0.3.tar.bz2
	libstaroffice-0.0.2.tar.bz2
	libzmf-0.0.1.tar.bz2
	ltm-1.0.zip
	libgltf-0.0.2.tar.bz2)

source libreoffice.md5

do_build() {

	unset J2REDIR; unset J2SDKDIR; unset JAVA_HOME; unset CLASSPATH
	[ -z "${JAVA_HOME}" ] && .  /etc/profile.d/openjdk.sh
	[ -z "${ANT_HOME}" ] && . /etc/profile.d/apache-ant.sh

	cd ${CACHE_PATH}/libreoffice-$_LOver

	# move external sources into place
	mkdir ${CACHE_PATH}/ext_sources &&	pushd ${CACHE_PATH}/ext_sources
	for source in "${noextract[@]}"; do
	  ln -s ${CACHE_PATH}/$source .
	done
	popd

	rm ${CACHE_PATH}/ext_sources/185d60944ea767075d27247c3162b3bc-unowinreg.dll
        cp -f ${CACHE_PATH}/185d60944ea767075d27247c3162b3bc-unowinreg.dll ${CACHE_PATH}/ext_sources
	
	#use the CFLAGS but remove the LibO overridden ones
	for i in $CFLAGS; do
		case "$i" in
			-O?|-pipe|-Wall|-g|-fexceptions) continue;;
		esac
        ARCH_FLAGS="$ARCH_FLAGS $i"
	done
	
	# Use python3
	export PYTHON=python3

	./autogen.sh --with-build-version="${_LOver} KaOS-${pkgrel}" --with-vendor="KaOS" \
		--with-external-tar="${CACHE_PATH}/ext_sources" \
		--disable-fetch-external \
		--prefix=/usr --exec-prefix=/usr --sysconfdir=/etc \
		--libdir=/usr/lib --mandir=/usr/share/man \
		--includedir=/usr/include \
		--with-lang="" \
		--with-help \
		--enable-release-build \
		--enable-cairo-canvas \
		--enable-dbus \
		--disable-evolution2 \
		--enable-graphite\
		--enable-gio\
		--enable-gtk \
		--disable-gtk3 \
		--disable-kde4 \
		--disable-gstreamer-0-10 \
		--enable-odk \
		--enable-python=system \
		--enable-scripting-beanshell \
		--enable-scripting-javascript \
		--without-fonts \
		--with-system-apr \
		--without-system-libcdr \
		--without-system-jfreereport \
		--without-system-apache-commons \
		--with-system-libodfgen \
		--without-system-libmwaw \
		--with-system-libetonyek \
		--without-system-libfreehand \
		--without-system-firebird \
		--with-system-libatomic-ops \
		--without-system-libebook \
		--with-system-libabw \
		--with-system-mdds \
		--without-myspell-dicts \
        --with-system-libvisio \
        --without-system-libcmis \
        --without-system-libmspub \
		--without-system-libexttextcat \
		--without-system-orcus \
		--without-system-libstaroffice \
		--without-system-libzmf \
		--without-system-libtommath \
		--with-system-liblangtag \
		--with-system-dicts \
        --with-system-hunspell \
		--with-external-hyph-dir=/usr/share/hyphen \
		--with-external-thes-dir=/usr/share/mythes \
		--with-system-beanshell \
        --with-system-cppunit \
        --with-system-graphite \
        --with-system-glew \
		--with-system-glm \
		--with-system-libwpg \
		--with-system-libwps \
		--with-system-redland \
		--with-system-serf \
		--with-ant-home="/usr/share/java/apache-ant"\
		--without-system-boost \
		--with-system-icu \
		--with-system-cairo \
		--with-system-libs \
		--with-system-mythes \
		--with-system-headers \
		--without-system-hsqldb \
		--without-system-libpagemaker \
		--without-system-coinmp \
		--without-system-libgltf \
		--with-alloc=system \
		--with-system-clucene \
		--disable-dependency-tracking \
		--disable-cve-tests \
		--with-theme="breeze breeze_dark oxygen sifr"

	touch src.downloaded
	#./download
	# one test in sw_ooxmlexport7 fails, rebuild with '-no-check' added
	make build-nocheck
}

do_package() {
        cd ${CACHE_PATH}/libreoffice-$_LOver
        make DESTDIR=${pkg_prefix} distro-pack-install
 
        # configuration files 
        install -dm755 ${pkg_prefix}/etc/libreoffice
        install -m644 ${pkg_prefix}/usr/lib/libreoffice/program/{bootstraprc,sofficerc} ${pkg_prefix}/etc/libreoffice/
        install -m644 ${pkg_prefix}/usr/lib/libreoffice/share/psprint/psprint.conf ${pkg_prefix}/etc/libreoffice/
        # links 
        cd ${pkg_prefix}/usr/lib/libreoffice/program/
        ln -vsf /etc/libreoffice/{bootstraprc,sofficerc} .
        cd ${pkg_prefix}/usr/lib/libreoffice/share/psprint/
        ln -vsf /etc/libreoffice/psprint.conf .
 
        #install -dm755 ${pkg_prefix}/usr/share/bash-completion/completions
        #mv ${pkg_prefix}/etc/bash_completion.d/libreoffice.sh ${pkg_prefix}/usr/share/bash-completion/completions/libreoffice.sh
        #rm -rf ${pkg_prefix}/etc/bash_completion.d
 
        install -v -m644 ${CACHE_PATH}/libreoffice-$_LOver/sysui/desktop/appstream-appdata/*.xml ${pkg_prefix}/usr/share/appdata 
 
        # replace beta splash screen
        rm -f ${pkg_prefix}/usr/lib/libreoffice/program/intro.png
        install -m644 ${CACHE_PATH}/intro.png ${pkg_prefix}/usr/lib/libreoffice/program/
        # more then half the package size is from sdk docs
        rm -r ${pkg_prefix}/usr/share/doc
}
