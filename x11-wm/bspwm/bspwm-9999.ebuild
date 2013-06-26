# $Header: $

## NOTE:  To be completely mirroring the 'bspwm' PKGBUILD,
## I will need to update this for all 'bskv' dependencies.
## Unless you use "examples", this ebuild should be fine..

EAPI=5

inherit bash-completion-r1 flag-o-matic git-2 toolchain-funcs

DESCRIPTION="A tiling window manager based on binary space partitioning"
HOMEPAGE="https://github.com/baskerville/bspwm"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/bspwm.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples sres sutils xtitle xdo dzen bar"

RESTRICT="strip"

RDEPEND=">=x11-libs/libxcb-1.9
	>=x11-libs/xcb-util-0.3.8
	>=x11-libs/xcb-util-wm-0.3.8
	>=x11-apps/sxhkd-0.3
	dzen? ( x11-misc/dzen )
	bar? ( sys-apps/bar )
	xtitle? ( x11-apps/xtitle )
	xdo? ( =x11-misc/xdo-9999 )
	sres? ( =x11-apps/sres-9999 )
	sutils? ( =x11-apps/sutils-9999 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	dobin bspwm bspc
	dodoc LICENSE

	doman doc/bspwm.1 doc/bspc.1
	
	newbashcomp bash_completion bspc

	if use examples ; then
		exeinto /usr/share/doc/${PF}/examples
		doexe examples/{autostart,sxhkdrc}
		exeinto /usr/share/doc/${PF}/examples/panel
		doexe examples/panel/*
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
