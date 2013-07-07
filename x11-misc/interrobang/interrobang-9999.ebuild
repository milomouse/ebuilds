# $Header: $

EAPI=5

inherit flag-o-matic git-2 toolchain-funcs

DESCRIPTION="A tiny launcher menu packing a big bang (syntax)"
HOMEPAGE="http://github.com/TrilbyWhite/interrobang.git"
SRC_URI=""
EGIT_REPO_URI="git://github.com/TrilbyWhite/interrobang.git"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RESTRICT="strip"

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}
	virtual/pkgconfig"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	dobin ${PN} percontation
	dodoc COPYING

	if use examples ; then
		exeinto /usr/share/doc/${PF}/examples
		doexe interrobangrc
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
