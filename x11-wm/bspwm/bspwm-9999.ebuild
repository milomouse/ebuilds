# $Header: $

## NOTE:  Need to update this for complete 'baskerville' dependencies.

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="A tiling window manager based on binary space partitioning"
HOMEPAGE="https://github.com/baskerville/bspwm"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/bspwm.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sres sutils xtitle xdo dzen bar"

RDEPEND=">=x11-libs/libxcb-1.9
	>=x11-libs/xcb-util-0.3.8
	>=x11-libs/xcb-util-wm-0.3.8
	xdo? ( =x11-misc/xdo-9999 )
	dzen? ( x11-misc/dzen )
	xtitle? ( x11-apps/xtitle )
	bar? ( sys-apps/bar )
	>=x11-apps/sxhkd-0.3
	sres? ( =x11-apps/sres-9999 )
	sutils? ( =x11-apps/sutils-9999 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
	install -D -m644 LICENSE "${D}/usr/share/licenses/bspwm/LICENSE"
}
