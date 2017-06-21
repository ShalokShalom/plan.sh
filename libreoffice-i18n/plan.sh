pkg_origin=

pkgbase="libreoffice-i18n"
pkg_name=('libreoffice-af'
         #'libreoffice-am'
         'libreoffice-ar'
         'libreoffice-as'
         'libreoffice-ast'
         'libreoffice-be'
         'libreoffice-bg'
         #'libreoffice-bn-IN'
         'libreoffice-bn'
         'libreoffice-bo'
         'libreoffice-br'
         'libreoffice-brx'
         'libreoffice-bs'
         'libreoffice-ca'
         'libreoffice-ca-valencia'
         'libreoffice-cs'
         'libreoffice-cy'
         'libreoffice-da'
         'libreoffice-de'
         'libreoffice-dgo'
         'libreoffice-dz'
         'libreoffice-el'
         #'libreoffice-en-GB'
         #'libreoffice-en-ZA'
         'libreoffice-eo'
         'libreoffice-es'
         'libreoffice-et'
         'libreoffice-eu'
         'libreoffice-fa'
         'libreoffice-fi'
         'libreoffice-fr'
         'libreoffice-ga'
         'libreoffice-gd'
         'libreoffice-gl'
         'libreoffice-gu'
         'libreoffice-he'
         'libreoffice-hi'
         'libreoffice-hr'
         'libreoffice-hu'
         'libreoffice-id'
         'libreoffice-is'
         'libreoffice-it'
         'libreoffice-ja'
         'libreoffice-ka'
         'libreoffice-kk'
         'libreoffice-km'
         'libreoffice-kn'
         'libreoffice-ko'
         'libreoffice-kok'
         'libreoffice-ks'
         #'libreoffice-ku'
         #'libreoffice-lb'
         'libreoffice-lo'
         'libreoffice-lt'
         'libreoffice-lv'
         'libreoffice-mai'
         'libreoffice-mk'
         'libreoffice-ml'
         'libreoffice-mn'
         'libreoffice-mni'
         'libreoffice-mr'
         'libreoffice-my'
         'libreoffice-nb'
         'libreoffice-ne'
         'libreoffice-nl'
         'libreoffice-nn'
         'libreoffice-nr'
         'libreoffice-nso'
         'libreoffice-oc'
         'libreoffice-om'
         'libreoffice-or'
         'libreoffice-pa-IN'
         'libreoffice-pl'
         'libreoffice-pt-BR'
         'libreoffice-pt'
         'libreoffice-ro'
         'libreoffice-ru'
         'libreoffice-rw'
         'libreoffice-sa-IN'
         'libreoffice-sat'
         'libreoffice-sd'
         #'libreoffice-sh'
         'libreoffice-si'
         #'libreoffice-sid'
         'libreoffice-sk'
         'libreoffice-sl'
         'libreoffice-sq'
         'libreoffice-sr'
         'libreoffice-ss'
         'libreoffice-st'
         'libreoffice-sv'
         'libreoffice-sw-TZ'
         'libreoffice-ta'
         'libreoffice-te'
         'libreoffice-tg'
         'libreoffice-th'
         'libreoffice-tn'
         'libreoffice-tr'
         'libreoffice-ts'
         #'libreoffice-tt'
         'libreoffice-ug'
         'libreoffice-uk'
         'libreoffice-uz'
         'libreoffice-ve'
         'libreoffice-vi'
         'libreoffice-xh'
         'libreoffice-zh-CN'
         'libreoffice-zh-TW'
         'libreoffice-zu')
pkg_version=5.3.3
pkg_description="LibreOffice language/localisation files"
pkg_upstream_url="https://www.documentfoundation.org"
pkg_license=('LGPL')
#pkg_deps=('libreoffice-common') #>=${pkg_version}")
pkg_build_deps=('rpmextract')
_pkg_upstream_url="http://ftp.acc.umu.se/mirror/documentfoundation.org/libreoffice/stable/"
#_pkg_upstream_url="http://dev-builds.libreoffice.org/pre-releases"
#_pkg_upstream_url="https://download.documentfoundation.org/libreoffice/testing"
_oover="5.3.3"
_oodlver="5.3.3"
_oomainver="5.3"
_helpver=${_oodlver}
_dirver="5.3.3.2"

pkg_source=( ##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_af.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_af.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_am.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ar.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ar.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_as.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_as.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ast.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ast.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_be.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_be.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_bg.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_bn.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_bo.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_br.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_br.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_brx.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_brx.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_bs.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ca-valencia.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ca.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_cs.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_cy.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_cy.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_da.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_de.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_dgo.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_dgo.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_dz.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_el.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_en-GB.tar.gz
	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_en-ZA.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_eo.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_es.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_et.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_eu.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_fa.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_fa.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_fi.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_fr.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ga.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ga.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_gd.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_gl.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_gu.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_he.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_hi.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_hr.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_hu.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_id.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_is.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_it.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ja.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ka.tar.gz
#	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_kid.tar.gz
	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_kk.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_kk.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_km.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_kn.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_kn.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ko.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_kok.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_kok.tar.gz
#	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ks.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ks.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ku.tar.gz
#	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ku.tar.gz
#	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ky.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_lo.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_lo.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_lt.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_lt.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_lv.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_lv.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_mai.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_mai.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_mk.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ml.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ml.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_mn.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_mn.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_mni.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_mni.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_mr.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_mr.tar.gz
#	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ms.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_my.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_my.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_nb.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ne.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_nl.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_nn.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_nr.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_nr.tar.gz
#	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_nso.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_nso.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_oc.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_oc.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_om.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_or.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_or.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_pa-IN.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_pa-IN.tar.gz
#	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_pap.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_pl.tar.gz
#	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ps.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_pt-BR.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_pt.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ro.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ro.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ru.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_rw.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_rw.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sa-IN.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_sa-IN.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sat.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_sat.tar.gz
#	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sc.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sd.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_sd.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sh.tar.gz
#	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_sh.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_si.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sk.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sl.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sq.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sr.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_sr.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ss.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ss.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_st.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_st.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sv.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_sw-TZ.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_sw-TZ.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ta.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ta.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_te.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_te.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_tg.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_th.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_th.tar.gz
#	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ti.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_tn.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_tn.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_tr.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ts.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ts.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ug.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_uk.tar.gz
#	#${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ur.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_uz.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_uz.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_ve.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_ve.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_vi.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_xh.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_xh.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_zh-CN.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_zh-TW.tar.gz
	##${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_{langpack,helppack}_zu.tar.gz
	${_url}/${_oodlver}/rpm/x86/LibreOffice_${_oover}_Linux_x86_rpm_langpack_zu.tar.gz)

source libreoffice-i18n.md5

do_build() {
  for i in ${pkg_name[@]}
   do _pkglang=${i#*-}
    echo ${_pkglang} " unpacking..."
    #cd ${CACHE_PATH}/LibreOffice_${_oover/-/}_Linux_x86_rpm_langpack_${_pkglang}/RPMS
    cd ${CACHE_PATH}/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_${_pkglang}/RPMS
    # remove dictionaries if shipped - we ship them now in separate packages
    rm -vf lo*-dict-*.rpm || /bin/true
	for j in *.rpm
	 do rpmextract.sh $j
	done
    # the helppack rpm goes also into the langpack dir - so far we don't want to split the helppacks separate
#     rpmextract.sh ${CACHE_PATH}/LibreOffice_${_oover/-/}_Linux_x86_helppack-rpm_${_pkglang}/RPMS/libobasis3.3-${_pkglang}-help-${_helpver}.i586.rpm
    #rpmextract.sh ${CACHE_PATH}/LibreOffice_${_oover/-/}_Linux_x86_helppack-rpm_${_pkglang}/RPMS/*.rpm
    rpmextract.sh ${CACHE_PATH}/LibreOffice_${_dirver}_Linux_x86_rpm_helppack_${_pkglang}/RPMS/*.rpm || /bin/true
  done
}

package_libreoffice-af() {
  pkg_description="Afrikaans language pack for LibreOffice"
  provides=('openoffice-af' 'libreoffice-langpack')
  replaces=(openoffice-af)
  conflicts=(openoffice-af)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_af/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ar() {
  pkg_description="Arabic language pack for LibreOffice"
  provides=('openoffice-ar' 'libreoffice-langpack')
  replaces=(openoffice-ar)
  conflicts=(openoffice-ar)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ar/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-as() {
  pkg_description="Assamese (India) language pack for LibreOffice"
  provides=('openoffice-as' 'libreoffice-langpack')
  replaces=(openoffice-as)
  conflicts=(openoffice-as)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_as/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ast() {
  pkg_description="Asturianu language pack for LibreOffice"
  provides=('openoffice-ast' 'libreoffice-langpack')
  replaces=(openoffice-ast)
  conflicts=(openoffice-ast)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ast/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-be() {
  pkg_description="Belarusian language pack for LibreOffice"
  provides=('openoffice-be-BY' 'libreoffice-langpack')
  replaces=(openoffice-be-BY)
  conflicts=(openoffice-be-BY)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_be/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-bg() {
  pkg_description="Bulgarian language pack for LibreOffice"
  provides=('openoffice-bg' 'libreoffice-langpack')
  replaces=(openoffice-bg)
  conflicts=(openoffice-bg)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_bg/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-bn() {
  pkg_description="Bengali language pack for LibreOffice"
  provides=('openoffice-bn' 'libreoffice-langpack')
  replaces=(openoffice-bn)
  conflicts=(openoffice-bn)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_bn/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-bo() {
  pkg_description="Tibetan language pack for LibreOffice"
  provides=('openoffice-bo' 'libreoffice-langpack')
  replaces=(openoffice-bo)
  conflicts=(openoffice-bo)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_bo/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-br() {
  pkg_description="Breton language pack for LibreOffice"
  provides=('openoffice-br' 'libreoffice-langpack')
  replaces=(openoffice-br)
  conflicts=(openoffice-br)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_br/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-brx() {
  pkg_description="Bodo language pack for LibreOffice"
  provides=('openoffice-brx' 'libreoffice-langpack')
  replaces=(openoffice-brx)
  conflicts=(openoffice-brx)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_brx/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-bs() {
  pkg_description="Bosnian language pack for LibreOffice"
  provides=('openoffice-bs' 'libreoffice-langpack')
  replaces=(openoffice-bs)
  conflicts=(openoffice-bs)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_bs/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ca() {
  pkg_description="Catalan language pack for LibreOffice"
  provides=('openoffice-ca' 'libreoffice-langpack')
  replaces=(openoffice-ca)
  conflicts=(openoffice-ca)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ca/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
  # conflict with libreoffice-es
  rm -rf "${pkg_prefix}"/usr/lib/libreoffice/share/extensions/dict-an
}

package_libreoffice-ca-valencia() {
  pkg_description="Catalan (Valencia) language pack for LibreOffice"
  provides=('libreoffice-ca-XV' 'libreoffice-ca-valencia' 'libreoffice-langpack')
  replaces=(libreoffice-ca-XV)
  conflicts=(libreoffice-ca-XV)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ca-valencia/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-cs() {
  pkg_description="Czech language pack for LibreOffice"
  provides=('openoffice-cs' 'libreoffice-langpack')
  replaces=(openoffice-cs)
  conflicts=(openoffice-cs)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_cs/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-cy() {
  pkg_description="Welsh language pack for LibreOffice"
  provides=('openoffice-cy' 'libreoffice-langpack')
  replaces=(openoffice-cy)
  conflicts=(openoffice-cy)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_cy/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-da() {
  pkg_description="Danish language pack for LibreOffice"
  provides=('openoffice-da' 'libreoffice-langpack')
  replaces=(openoffice-da)
  conflicts=(openoffice-da)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_da/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-de() {
  pkg_description="German language pack for LibreOffice"
  provides=('openoffice-de' 'libreoffice-langpack')
  replaces=(openoffice-de)
  conflicts=(openoffice-de)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_de/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-dgo() {
  pkg_description="Dogri language pack for LibreOffice"
  provides=('openoffice-dgo' 'libreoffice-langpack')
  replaces=(openoffice-dgo)
  conflicts=(openoffice-dgo)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_dgo/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-dz() {
  pkg_description="Dzongkha language pack for LibreOffice"
  provides=('openoffice-dz' 'libreoffice-langpack')
  replaces=(openoffice-dz)
  conflicts=(openoffice-dz)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_dz/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-el() {
  pkg_description="Greek language pack for LibreOffice"
  provides=('openoffice-el' 'libreoffice-langpack')
  replaces=(openoffice-el)
  conflicts=(openoffice-el)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_el/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-en-GB() {
  pkg_description="English (GB) language pack for LibreOffice"
  provides=('openoffice-en-GB' 'libreoffice-langpack')
  replaces=(openoffice-en-GB)
  conflicts=(openoffice-en-GB)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_en-GB/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-en-ZA() {
  pkg_description="English (ZA) language pack for LibreOffice"
  provides=('openoffice-en-ZA' 'libreoffice-langpack')
  replaces=(openoffice-en-ZA)
  conflicts=(openoffice-en-ZA)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_en-ZA/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-eo() {
  pkg_description="Esperanto language pack for LibreOffice"
  provides=('openoffice-eo' 'libreoffice-langpack')
  replaces=(openoffice-eo)
  conflicts=(openoffice-eo)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_eo/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-es() {
  pkg_description="Spanish language pack for LibreOffice"
  provides=('openoffice-es' 'libreoffice-langpack')
  replaces=(openoffice-es)
  conflicts=(openoffice-es)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_es/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-et() {
  pkg_description="Estonian language pack for LibreOffice"
  provides=('openoffice-et' 'libreoffice-langpack')
  replaces=(openoffice-et)
  conflicts=(openoffice-et)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_et/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-eu() {
  pkg_description="Basque language pack for LibreOffice"
  provides=('openoffice-eu' 'libreoffice-langpack')
  replaces=(openoffice-eu)
  conflicts=(openoffice-eu)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_eu/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-fa() {
  pkg_description="Persian language pack for LibreOffice"
  provides=('openoffice-fa' 'libreoffice-langpack')
  replaces=(openoffice-fa)
  conflicts=(openoffice-fa)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_fa/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-fi() {
  pkg_description="Finnish language pack for LibreOffice"
  provides=('openoffice-fi' 'libreoffice-langpack')
  replaces=(openoffice-fi)
  conflicts=(openoffice-fi)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_fi/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-fr() {
  pkg_description="French language pack for LibreOffice"
  provides=('openoffice-fr' 'libreoffice-langpack')
  replaces=(openoffice-fr)
  conflicts=(openoffice-fr)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_fr/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ga() {
  pkg_description="Irish language pack for LibreOffice"
  provides=('openoffice-ga' 'libreoffice-langpack')
  replaces=(openoffice-ga)
  conflicts=(openoffice-ga)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ga/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-gd() {
  pkg_description="Irish language pack for LibreOffice"
  provides=('openoffice-gd' 'libreoffice-langpack')
  replaces=(openoffice-gd)
  conflicts=(openoffice-gd)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_gd/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}
package_libreoffice-gl() {
  pkg_description="Galician language pack for LibreOffice"
  provides=('openoffice-gl' 'libreoffice-langpack')
  replaces=(openoffice-gl)
  conflicts=(openoffice-gl)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_gl/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-gu() {
  pkg_description="Gujarati language pack for LibreOffice"
  provides=('openoffice-gu' 'libreoffice-langpack')
  replaces=(openoffice-gu)
  conflicts=(openoffice-gu)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_gu/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-he() {
  pkg_description="Hebrew language pack for LibreOffice"
  provides=('openoffice-he' 'libreoffice-langpack')
  replaces=(openoffice-he)
  conflicts=(openoffice-he)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_he/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-hi() {
  pkg_description="Hindi language pack for LibreOffice"
  provides=('openoffice-hi' 'libreoffice-langpack')
  replaces=(openoffice-hi)
  conflicts=(openoffice-hi)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_hi/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-hr() {
  pkg_description="Croatian language pack for LibreOffice"
  provides=('openoffice-hr' 'libreoffice-langpack')
  replaces=(openoffice-hr)
  conflicts=(openoffice-hr)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_hr/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-hu() {
  pkg_description="Hungarian language pack for LibreOffice"
  provides=('openoffice-hu' 'libreoffice-langpack')
  replaces=(openoffice-hu)
  conflicts=(openoffice-hu)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_hu/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-id() {
  pkg_description="Bahasa Indonesia language pack for LibreOffice"
  provides=('openoffice-id' 'libreoffice-langpack')
  replaces=(openoffice-id)
  conflicts=(openoffice-id)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_id/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-is() {
  pkg_description="Icelandic language pack for LibreOffice"
  provides=('openoffice-is' 'libreoffice-langpack')
  replaces=(openoffice-is)
  conflicts=(openoffice-is)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_is/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-it() {
  pkg_description="Italian language pack for LibreOffice"
  provides=('openoffice-it' 'libreoffice-langpack')
  replaces=(openoffice-it)
  conflicts=(openoffice-it)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_it/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ja() {
  pkg_description="Japanese language pack for LibreOffice"
  provides=('openoffice-ja' 'libreoffice-langpack')
  replaces=(openoffice-ja)
  conflicts=(openoffice-ja)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ja/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ka() {
  pkg_description="Georgian language pack for LibreOffice"
  provides=('openoffice-ka' 'libreoffice-langpack')
  replaces=(openoffice-ka)
  conflicts=(openoffice-ka)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ka/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-kk() {
  pkg_description="Kazakh language pack for LibreOffice"
  provides=('openoffice-kk' 'libreoffice-langpack')
  replaces=(openoffice-kk)
  conflicts=(openoffice-kk)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_kk/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-km() {
  pkg_description="Khmer (Cambodia) language pack for LibreOffice"
  provides=('openoffice-km' 'libreoffice-langpack')
  replaces=(openoffice-km)
  conflicts=(openoffice-km)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_km/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-kn() {
  pkg_description="Kannada language pack for LibreOffice"
  provides=('openoffice-kn' 'libreoffice-langpack')
  replaces=(openoffice-kn)
  conflicts=(openoffice-kn)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_kn/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ko() {
  pkg_description="Korean language pack for LibreOffice"
  provides=('openoffice-ko' 'libreoffice-langpack')
  replaces=(openoffice-ko)
  conflicts=(openoffice-ko)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ko/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-kok() {
  pkg_description="Konkani language pack for LibreOffice"
  provides=('openoffice-kok' 'libreoffice-langpack')
  replaces=(openoffice-kok)
  conflicts=(openoffice-kok)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_kok/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ks() {
  pkg_description="Kashmiri language pack for LibreOffice"
  provides=('openoffice-ks' 'libreoffice-langpack')
  replaces=(openoffice-ks)
  conflicts=(openoffice-ks)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ks/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ku() {
  pkg_description="Kurdish language pack for LibreOffice"
  provides=('openoffice-ku' 'libreoffice-langpack')
  replaces=(openoffice-ku)
  conflicts=(openoffice-ku)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ku/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-lo() {
  pkg_description="Lao language pack for LibreOffice"
  provides=('openoffice-lo' 'libreoffice-langpack')
  replaces=(openoffice-lo)
  conflicts=(openoffice-lo)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_lo/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-lt() {
  pkg_description="Lithuanian language pack for LibreOffice"
  provides=('openoffice-lt' 'libreoffice-langpack')
  replaces=(openoffice-lt)
  conflicts=(openoffice-lt)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_lt/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-lv() {
  pkg_description="Latvian language pack for LibreOffice"
  provides=('openoffice-lv' 'libreoffice-langpack')
  replaces=(openoffice-lv)
  conflicts=(openoffice-lv)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_lv/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-mai() {
  pkg_description="Maithili language pack for LibreOffice"
  provides=('openoffice-mai' 'libreoffice-langpack')
  replaces=(openoffice-mai)
  conflicts=(openoffice-mai)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_mai/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-mk() {
  pkg_description="Macedonian language pack for LibreOffice"
  provides=('openoffice-mk' 'libreoffice-langpack')
  replaces=(openoffice-mk)
  conflicts=(openoffice-mk)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_mk/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ml() {
  pkg_description="Malayalam language pack for LibreOffice"
  provides=('openoffice-ml' 'libreoffice-langpack')
  replaces=(openoffice-ml)
  conflicts=(openoffice-ml)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ml/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-mn() {
  pkg_description="Mongolian language pack for LibreOffice"
  provides=('openoffice-mn' 'libreoffice-langpack')
  replaces=(openoffice-mn)
  conflicts=(openoffice-mn)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_mn/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-mni() {
  pkg_description="Manipuri language pack for LibreOffice"
  provides=('openoffice-mni' 'libreoffice-langpack')
  replaces=(openoffice-mni)
  conflicts=(openoffice-mni)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_mni/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-mr() {
  pkg_description="Marathi language pack for LibreOffice"
  provides=('openoffice-mr' 'libreoffice-langpack')
  replaces=(openoffice-mr)
  conflicts=(openoffice-mr)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_mr/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-my() {
  pkg_description="Burmese language pack for LibreOffice"
  provides=('openoffice-my' 'libreoffice-langpack')
  replaces=(openoffice-my)
  conflicts=(openoffice-my)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_my/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-nb() {
  pkg_description="Norwegian Bokmal language pack for LibreOffice"
  provides=('openoffice-nb' 'libreoffice-langpack')
  replaces=(openoffice-nb)
  conflicts=(openoffice-nb)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_nb/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ne() {
  pkg_description="Nepali language pack for LibreOffice"
  provides=('openoffice-ne' 'libreoffice-langpack')
  replaces=('openoffice-ne')
  conflicts=(openoffice-ne)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ne/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-nl() {
  pkg_description="Dutch language pack for LibreOffice"
  provides=('openoffice-nl' 'libreoffice-langpack')
  replaces=(openoffice-nl)
  conflicts=(openoffice-nl)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_nl/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-nn() {
  pkg_description="Norwegian Nynorsk language pack for LibreOffice"
  provides=('openoffice-nn' 'libreoffice-langpack')
  replaces=(openoffice-nn)
  conflicts=(openoffice-nn)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_nn/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-nr() {
  pkg_description="Ndebele (South) language pack for LibreOffice"
  provides=(openoffice-nr)
  replaces=(openoffice-nr)
  conflicts=(openoffice-nr)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_nr/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-nso() {
  pkg_description="Northern Sotho language pack for LibreOffice"
  provides=('openoffice-ns' 'libreoffice-ns' 'libreoffice-langpack')
  replaces=('openoffice-ns' 'libreoffice-ns')
  conflicts=(openoffice-ns)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_nso/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-oc() {
  pkg_description="Occitan language pack for LibreOffice"
  provides=('openoffice-oc' 'libreoffice-langpack')
  replaces=(openoffice-oc)
  conflicts=(openoffice-oc)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_oc/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-om() {
  pkg_description="Oromo language pack for LibreOffice"
  provides=('openoffice-om' 'libreoffice-langpack')
  replaces=(openoffice-om)
  conflicts=(openoffice-om)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_om/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-or() {
  pkg_description="Oriya language pack for LibreOffice"
  provides=('openoffice-or' 'libreoffice-langpack')
  replaces=(openoffice-or)
  conflicts=(openoffice-or)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_or/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-pa-IN() {
  pkg_description="Punjabi (India) language pack for LibreOffice"
  provides=('openoffice-pa-IN' 'libreoffice-langpack')
  replaces=(openoffice-pa-IN)
  conflicts=(openoffice-pa-IN)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_pa-IN/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-pl() {
  pkg_description="Polish language pack for LibreOffice"
  provides=('openoffice-pl' 'libreoffice-langpack')
  replaces=(openoffice-pl)
  conflicts=(openoffice-pl)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_pl/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-pt-BR() {
  pkg_description="Portuguese (Brasil) language pack for LibreOffice"
  provides=('openoffice-pt-BR' 'libreoffice-langpack')
  replaces=(openoffice-pt-BR)
  conflicts=(openoffice-pt-BR)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_pt-BR/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-pt() {
  pkg_description="Portuguese language pack for LibreOffice"
  provides=('openoffice-pt' 'libreoffice-langpack')
  replaces=(openoffice-pt)
  conflicts=(openoffice-pt)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_pt/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ro() {
  pkg_description="Romanian language pack for LibreOffice"
  provides=('openoffice-ro' 'libreoffice-langpack')
  replaces=(openoffice-ro)
  conflicts=(openoffice-ro)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ro/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ru() {
  pkg_description="Russian language pack for LibreOffice"
  provides=('openoffice-ru' 'libreoffice-langpack')
  replaces=(openoffice-ru)
  conflicts=(openoffice-ru)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ru/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-rw() {
  pkg_description="Kinyarwanda language pack for LibreOffice"
  provides=('openoffice-rw' 'libreoffice-langpack')
  replaces=(openoffice-rw)
  conflicts=(openoffice-rw)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_rw/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-sa-IN() {
  pkg_description="Sanskrit (India) language pack for LibreOffice"
  provides=('openoffice-sa-IN' 'libreoffice-langpack')
  replaces=(openoffice-sa-IN)
  conflicts=(openoffice-sa-IN)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_sa-IN/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-sat() {
  pkg_description="Santali language pack for LibreOffice"
  provides=('openoffice-sat' 'libreoffice-langpack')
  replaces=(openoffice-sat)
  conflicts=(openoffice-sat)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_sat/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-sd() {
  pkg_description="Sindhi language pack for LibreOffice"
  provides=('openoffice-sd' 'libreoffice-langpack')
  replaces=(openoffice-sd)
  conflicts=(openoffice-sd)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_sd/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-sh() {
  pkg_description="Serbo-Croatian language pack for LibreOffice"
  provides=('openoffice-sh' 'libreoffice-langpack')
  replaces=(openoffice-sh)
  conflicts=(openoffice-sh)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_sh/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-si() {
  pkg_description="Singhalese language pack for LibreOffice"
  provides=('openoffice-si' 'libreoffice-langpack')
  replaces=(openoffice-si)
  conflicts=(openoffice-si)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_si/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-sk() {
  pkg_description="Slovak language pack for LibreOffice"
  provides=('openoffice-sk' 'libreoffice-langpack')
  replaces=(openoffice-sk)
  conflicts=(openoffice-sk)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_sk/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-sl() {
  pkg_description="Slovenian language pack for LibreOffice"
  provides=('openoffice-sl' 'libreoffice-langpack')
  replaces=(openoffice-sl)
  conflicts=(openoffice-sl)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_sl/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-sq() {
  pkg_description="Albanien language pack for LibreOffice"
  provides=('openoffice-sq' 'libreoffice-langpack')
  replaces=(openoffice-sq)
  conflicts=(openoffice-sq)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_sq/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-sr() {
  pkg_description="Serbian language pack for LibreOffice"
  provides=('openoffice-sr' 'libreoffice-langpack')
  replaces=(openoffice-sr)
  conflicts=(openoffice-sr)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_sr/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ss() {
  pkg_description="Swati language pack for LibreOffice"
  provides=('openoffice-ss' 'libreoffice-langpack')
  replaces=(openoffice-ss)
  conflicts=(openoffice-ss)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ss/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-st() {
  pkg_description="Southern Sotho language pack for LibreOffice"
  provides=('openoffice-st' 'libreoffice-langpack')
  replaces=(openoffice-st)
  conflicts=(openoffice-st)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_st/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-sv() {
  pkg_description="Swedish language pack for LibreOffice"
  provides=('openoffice-sv' 'libreoffice-langpack')
  replaces=(openoffice-sv)
  conflicts=(openoffice-sv)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_sv/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-sw-TZ() {
  pkg_description="Swahili (Tanzania) language pack for LibreOffice"
  provides=('openoffice-sw-TZ' 'libreoffice-langpack')
  replaces=(openoffice-sw-TZ)
  conflicts=(openoffice-sw-TZ)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_sw-TZ/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ta() {
  pkg_description="Tamil language pack for LibreOffice"
  provides=('openoffice-ta' 'libreoffice-langpack')
  replaces=(openoffice-ta)
  conflicts=(openoffice-ta)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ta/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-te() {
  pkg_description="Telugu language pack for LibreOffice"
  provides=('openoffice-te' 'libreoffice-langpack')
  replaces=(openoffice-te)
  conflicts=(openoffice-te)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_te/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-tg() {
  pkg_description="Tajik language pack for LibreOffice"
  provides=('openoffice-tg' 'libreoffice-langpack')
  replaces=(openoffice-tg)
  conflicts=(openoffice-tg)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_tg/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-th() {
  pkg_description="Thai language pack for LibreOffice"
  provides=('openoffice-th' 'libreoffice-langpack')
  replaces=(openoffice-th)
  conflicts=(openoffice-th)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_th/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-tn() {
  pkg_description="Tswana language pack for LibreOffice"
  provides=('openoffice-tn' 'libreoffice-langpack')
  replaces=(openoffice-tn)
  conflicts=(openoffice-tn)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_tn/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-tr() {
  pkg_description="Turkish language pack for LibreOffice"
  provides=('openoffice-tr' 'libreoffice-langpack')
  replaces=(openoffice-tr)
  conflicts=(openoffice-tr)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_tr/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ts() {
  pkg_description="Tsonga language pack for LibreOffice"
  provides=('openoffice-ts' 'libreoffice-langpack')
  replaces=(openoffice-ts)
  conflicts=(openoffice-ts)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ts/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ug() {
  pkg_description="Uighur language pack for LibreOffice"
  provides=('openoffice-ug' 'libreoffice-langpack')
  replaces=(openoffice-ug)
  conflicts=(openoffice-ug)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ug/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-uk() {
  pkg_description="Ukrainian language pack for LibreOffice"
  provides=('openoffice-uk' 'libreoffice-langpack')
  replaces=(openoffice-uk)
  conflicts=(openoffice-uk)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_uk/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-uz() {
  pkg_description="Uzbek language pack for LibreOffice"
  provides=('openoffice-uz' 'libreoffice-langpack')
  replaces=(openoffice-uz)
  conflicts=(openoffice-uz)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_uz/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-ve() {
  pkg_description="Venda language pack for LibreOffice"
  provides=('openoffice-ve' 'libreoffice-langpack')
  replaces=(openoffice-ve)
  conflicts=(openoffice-ve)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_ve/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-vi() {
  pkg_description="Vietnamese language pack for LibreOffice"
  provides=('openoffice-vi' 'libreoffice-langpack')
  replaces=(openoffice-vi)
  conflicts=(openoffice-vi)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_vi/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-xh() {
  pkg_description="Xhosa language pack for LibreOffice"
  provides=('openoffice-xh' 'libreoffice-langpack')
  replaces=(openoffice-xh)
  conflicts=(openoffice-xh)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_xh/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-zh-CN() {
  pkg_description="Chinese (simplified) language pack for LibreOffice"
  provides=('openoffice-zh-CN' 'libreoffice-langpack')
  replaces=(openoffice-zh-CN)
  conflicts=(openoffice-zh-CN)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_zh-CN/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-zh-TW() {
  pkg_description="Chinese (traditional) language pack for LibreOffice"
  provides=('openoffice-zh-TW' 'libreoffice-langpack')
  replaces=(openoffice-zh-TW)
  conflicts=(openoffice-zh-TW)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_zh-TW/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}

package_libreoffice-zu() {
  pkg_description="Zulu language pack for LibreOffice"
  provides=('openoffice-zu' 'libreoffice-langpack')
  replaces=(openoffice-zu)
  conflicts=(openoffice-zu)
  cd "${CACHE_PATH}"/LibreOffice_${_dirver}_Linux_x86_rpm_langpack_zu/RPMS
  mkdir -p "${pkg_prefix}"/usr/lib/libreoffice
  cp -R opt/libreoffice5.3/* "${pkg_prefix}"/usr/lib/libreoffice
  chown root:root -R "${pkg_prefix}"/usr/lib/libreoffice
}
