# $Header: $

EAPI=5

inherit bash-completion-r1 flag-o-matic git-2 toolchain-funcs

DESCRIPTION="A tiling window manager based on binary space partitioning"
HOMEPAGE="https://github.com/baskerville/bspwm"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/bspwm.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples dmenu interrobang xdo sutils xtitle sres txtw dzen bar"

RESTRICT="strip"

RDEPEND=">=x11-libs/libxcb-1.9
	>=x11-libs/xcb-util-0.3.8
	>=x11-libs/xcb-util-wm-0.3.8
	>=x11-apps/sxhkd-0.3
	dmenu? ( x11-misc/dmenu )
	interrobang? ( =x11-misc/interrobang-9999 )
	xdo? ( =x11-misc/xdo-9999 )
	sutils? ( =x11-apps/sutils-9999 )
	xtitle? ( =x11-apps/xtitle-9999 )
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
	dobin bspwm bspc
	dodoc LICENSE

	doman doc/bspwm.1 doc/bspc.1
	
	newbashcomp bash_completion bspc

	if use examples ; then
		exeinto /usr/share/doc/${PF}/examples
		doexe examples/{autostart,sxhkdrc}
		exeinto /usr/share/doc/${PF}/examples/panel
		doexe examples/panel/*
		exeinto /usr/share/doc/${PF}/examples/loop
		doexe examples/loop/*
		exeinto /usr/share/doc/${PF}/examples/misc
		doexe examples/misc/*
		exeinto /usr/share/doc/${PF}/examples/overlapping_borders
		doexe examples/overlapping_borders/*
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
