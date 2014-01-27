# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ cl-clx-0.7.4-r1

EAPI=2
inherit common-lisp eutils

DESCRIPTION="CLX is the Common Lisp interface to the X11 protocol primarily for SBCL."
HOMEPAGE="http://www.cliki.net/CLX"
SRC_URI="http://common-lisp.net/~abridgewater/dist/clx/clx-${PV}.tgz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	sys-apps/texinfo"

CLPACKAGE=clx
S=${WORKDIR}/clx-${PV}

src_unpack() {

	unpack ${A}
	cd "${S}"
	rm {exclcmac,sockcl,defsystem,provide,cmudep}.lisp

}

src_prepare() {

	epatch "${FILESDIR}"/gentoo-fix-asd.patch
	epatch "${FILESDIR}"/gentoo-fix-dep-openmcl.patch
	epatch "${FILESDIR}"/gentoo-fix-unused-vars.patch
	epatch "${FILESDIR}"/gentoo-fix-obsolete-eval-when.patch

}

src_compile() {

	cd manual
	makeinfo ${CLPACKAGE}.texinfo -o ${CLPACKAGE}.info || die

}

src_install() {

	common-lisp-install *.{lisp,asd} {debug,demo,test}/*.lisp
	common-lisp-system-symlink clx
	dodoc NEWS CHANGES README*
	doinfo manual/${CLPACKAGE}.info

}
