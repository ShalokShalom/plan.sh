pkg_origin=cosmos

pkg_name=ca-certificates-java
pkg_version=20121112+nmu2
pkg_description='Common CA certificates (JKS keystore)'
pkg_upstream_url='https://packages.qa.debian.org/c/ca-certificates-java.html'
pkg_license=('GPL')
pkg_deps=('ca-certificates')
pkg_build_deps=('java-runtime')
install='ca-certificates-java.install'
backup=('etc/default/cacerts')
pkg_source=("http://ftp.debian.org/debian/pool/main/c/ca-certificates-java/${pkg_name}_${pkg_version}.tar.gz"
        'init-jks-keystore'
        'jks-keystore.hook')
pkg_shasum=('9562403f0cc9300d29af5b8baa9ddeab'
         '75eeca3f443f4b5a17ed5ac81875f1e9'
         '6dd4f915aee0df51260083e00b7fa012')

do_build() {

    javac -target 1.6 -source 1.6 UpdateCertificates.java
    jar cfe ca-certificates-java.jar UpdateCertificates *.class
}

do_package() {

    install -d -m755 ${pkg_prefix}/etc/ssl/certs/java
    install -D -m600 debian/default ${pkg_prefix}/etc/default/cacerts
    install -D -m644 ca-certificates-java.jar ${pkg_prefix}/usr/share/ca-certificates-java/ca-certificates-java.jar
    install -D -m755 ${CACHE_PATH}/init-jks-keystore ${pkg_prefix}/usr/sbin/init-jks-keystore
    install -D -m755 ${CACHE_PATH}/jks-keystore.hook ${pkg_prefix}/etc/ca-certificates/update.d/jks-keystore
}
