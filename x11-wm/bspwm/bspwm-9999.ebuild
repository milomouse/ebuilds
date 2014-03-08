# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ bspwm-9999

EAPI=5

inherit bash-completion-r1 flag-o-matic git-2 toolchain-funcs

DESCRIPTION="A tiling window manager based on binary space partitioning"
HOMEPAGE="https://github.com/baskerville/bspwm"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/bspwm.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples bash-completion zsh-completion dmenu interrobang sutils xdo xtitle xwinfo sres txtw dzen bar"

RESTRICT="strip"

RDEPEND=">=x11-libs/libxcb-1.9
	>=x11-libs/xcb-util-0.3.8
	>=x11-libs/xcb-util-wm-0.3.8
	>=x11-misc/sxhkd-0.3
	bash-completion? ( app-shells/bash-completion )
	zsh-completion? ( app-shells/zsh-completion )
	dmenu? ( x11-misc/dmenu )
	interrobang? ( =x11-misc/interrobang-9999 )
	sutils? ( =x11-apps/sutils-9999 )
	xdo? ( =x11-misc/xdo-9999 )
	xtitle? ( =x11-apps/xtitle-9999 )
	xwinfo? ( =x11-apps/xwinfo-9999 )
	sres? ( =x11-apps/sres-9999 )
	txtw? ( =x11-misc/txtw-9999 )
	dzen? ( x11-misc/dzen )
	bar? ( sys-apps/bar )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {

	emake PREFIX=/usr

}

src_install() {

	emake PREFIX="/usr" DESTDIR="${D}" install
	make_session_desktop bspwm /usr/bin/bspwm

	dodoc LICENSE

	if use bash-completion ; then
		newbashcomp contrib/bash_completion bspc
	fi

	if use zsh-completion ; then
		dodir /usr/share/zsh/site-functions/
		insinto /usr/share/zsh/site-functions/
		newins "${S}"/contrib/zsh_completion _bspc
	fi

	if use examples ; then
		dodir /usr/share/doc/"${PF}"/examples/
		dodir /usr/share/doc/"${PF}"/contrib/
		cp -R "${S}"/examples/* "${D}"/usr/share/doc/"${PF}"/examples/
		cp -R "${S}"/contrib/* "${D}"/usr/share/doc/"${PF}"/contrib/
		docompress -x /usr/share/doc/${PF}/
	fi

}
