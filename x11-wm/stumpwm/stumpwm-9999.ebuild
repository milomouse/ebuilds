# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ stumpwm-9999

EAPI=5

inherit common-lisp-common elisp-common eutils autotools git-2

DESCRIPTION="Stumpwm is a tiling, keyboard driven X11 Window Manager written entirely in Common Lisp."
HOMEPAGE="http://www.nongnu.org/stumpwm/"
EGIT_REPO_URI="git://github.com/sabetts/stumpwm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc"
IUSE="+doc contrib source +sbcl clisp +stumpish emacs"

RESTRICT="strip mirror"

RDEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller
	dev-lisp/cl-ppcre
	!sbcl? ( !clisp? ( >=dev-lisp/sbcl-1.0.32 ) )
	!sbcl? ( clisp? ( >=dev-lisp/clisp-2.38-r2[X,new-clx] ) )
	sbcl? ( >=dev-lisp/cl-clx-0.7.3-r1 >=dev-lisp/sbcl-1.0.32 )
	emacs? ( virtual/emacs app-emacs/slime )
	stumpish? ( app-misc/rlwrap )"
DEPEND="${RDEPEND}
	doc? ( sys-apps/texinfo )"

src_prepare() {

	rm -rf .git*
	cp "${FILESDIR}"/contrib/*.lisp contrib/
	mv contrib/notifications.lisp contrib/notification.lisp

	for i in "${FILESDIR}"/${PV}-*.patch ; do
		epatch $i
	done

	eautoreconf

}

src_configure() {

	use contrib && ECONF_OPTS="${ECONF_OPTS} --with-contrib-dir=${CLSOURCEROOT}/${PN}/contrib" 
	use clisp && ECONF_OPTS="${ECONF_OPTS} --with-lisp=clisp --with-ppcre=${CLSOURCEROOT}/cl-ppcre"

	econf ${ECONF_OPTS}

}

src_compile() {

	if [ -a /usr/share/common-lisp/systems/${PN}.asd ] ; then
		addwrite /usr/share/common-lisp/systems/
		rm -rf /usr/share/common-lisp/systems/${PN}.asd
	fi

	emake ${PN}

	if use doc ; then
		emake ${PN}.info
	fi

	if use emacs ; then
	    elisp-compile contrib/*.el
	fi

}

src_install() {

	dobin ${PN}
	make_session_desktop StumpWM /usr/bin/${PN}

	cp "${FILESDIR}"/README.Gentoo . && sed -i "s:@VERSION@:${PV}:" README.Gentoo
	[[ -f README.md && ! -f README ]] && mv README.md README
	nonfatal dodoc COPYING NEWS README README.Gentoo
	use doc && doinfo ${PN}.info
	docinto examples ; dodoc sample-stumpwmrc.lisp

	use stumpish && dobin contrib/stumpish
	use contrib && common-lisp-install contrib/*.lisp

	if use source ; then
		common-lisp-install *.{lisp,asd}
		common-lisp-system-symlink
	fi

}

pkg_postinst() {

	use emacs && elisp-site-regen

}

pkg_postrm() {

	use emacs && elisp-site-regen
}
