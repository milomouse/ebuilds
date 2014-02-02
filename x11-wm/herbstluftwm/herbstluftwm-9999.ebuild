# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ herbstluftwm-9999

EAPI=5
inherit toolchain-funcs bash-completion-r1 git-r3

DESCRIPTION="A manual tiling window manager for X"
HOMEPAGE="http://herbstluftwm.org"
EGIT_REPO_URI="git://github.com/milomouse/herbstluftwm.git"
EXTRA_DEPEND="app-text/asciidoc"

KEYWORDS="~amd64 ~x86"
LICENSE="BSD-2"
SLOT="0"
IUSE="examples xinerama zsh-completion"

CDEPEND=">=dev-libs/glib-2.24:2
	x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${CDEPEND}
	app-shells/bash
	zsh-completion? ( app-shells/zsh )"
DEPEND="${CDEPEND}
	${EXTRA_DEPEND}
	virtual/pkgconfig"

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getCC)" COLOR=0 VERBOSE= \
		$(use xinerama || echo XINERAMAFLAGS= XINERAMALIBS= )
}

src_install() {
	dobin herbstluftwm herbstclient
	nonfatal dodoc BUGS MIGRATION NEWS README Changelog

	doman doc/{herbstluftwm,herbstclient}.1

	exeinto /etc/xdg/herbstluftwm
	doexe share/{autostart,panel.sh,restartpanels.sh}

	insinto /usr/share/xsessions
	doins share/herbstluftwm.desktop

	newbashcomp share/herbstclient-completion herbstclient

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins share/_herbstclient
	fi

	if use examples ; then
		exeinto /usr/share/doc/${PF}/examples
		doexe scripts/*.sh
		docinto examples
		dodoc scripts/README
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
