# $Header: $

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="Small X utility to perform elementary actions on windows"
HOMEPAGE="https://github.com/baskerville/xdo"
SRC_URI=""
EGIT_REPO_URI="git://github.com/baskerville/xdo.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/libxcb-1.9
	x11-libs/xcb-util-wm"
DEPEND="virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
	install -D -m644 LICENSE "${D}/usr/share/licenses/xdo/LICENSE"
}
