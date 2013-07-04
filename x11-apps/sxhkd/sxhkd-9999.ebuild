# $Header: $

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="A simple X hotkey daemon"
HOMEPAGE="https://github.com/baskerville/sxhkd"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/sxhkd.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="examples"

RESTRICT="strip"

RDEPEND=">=x11-libs/libxcb-1.9
	>=x11-libs/xcb-util-keysyms-0.3.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	dobin ${PN}
	dodoc LICENSE

	doman doc/${PN}.1

	if use examples ; then
		exeinto /usr/share/doc/${PF}/examples/notification
		doexe examples/notification/*
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
