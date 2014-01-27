# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ dzen-9999

inherit flag-o-matic git-2 toolchain-funcs

SLOT="2"
MY_P="${PN}${SLOT}-${PV}"

DESCRIPTION="a general purpose messaging, notification and menuing program for X11."
HOMEPAGE="http://gotmor.googlepages.com/dzen"
SRC_URI=""
EGIT_REPO_URI="git://github.com/robm/dzen.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal xinerama xpm xft"

RDEPEND="x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )
	xpm? ( x11-libs/libXpm )
	xft? ( x11-libs/libXft )"
DEPEND="${RDEPEND}
	xinerama? ( x11-proto/xineramaproto )"

S=${WORKDIR}/${MY_P}

src_compile() {
	cd "${S}"
	sed -i \
		-e 's:../dzen2:dzen2:' \
		gadgets/kittscanner.sh || die

	sed -e "s:/usr/local:/usr:g" \
		-e 's:-Os::g' \
		-e "s:CFLAGS =:CFLAGS +=:g" \
		-e '/^CC.*/d' \
		-e 's:^LDFLAGS =:LDFLAGS +=:' \
		-e "s:/usr/lib :/usr/$(get_libdir):" \
		-i config.mk gadgets/config.mk || die "sed failed"
	sed -i -e "/strip/d" Makefile gadgets/Makefile || die "sed failed"
	if use xinerama ; then
		sed -e "/^LIBS/s/$/\ -lXinerama/" \
			-e "/^CFLAGS/s/$/\ -DDZEN_XINERAMA/" \
			-i config.mk || die "sed failed"
	fi
	if use xpm ; then
		sed -e "/^LIBS/s/$/\ -lXpm/" \
			-e "/^CFLAGS/s/$/\ -DDZEN_XPM/" \
			-i config.mk || die "sed failed"
	fi
	if use xft ; then
		sed -e "/^LIBS/s/$/\ -lXft/" \
			-e "/^CFLAGS/s/$/\ -DDZEN_XFT/" \
			-i config.mk || die "sed failed"
	fi

	tc-export CC
	emake X11INC=/usr/include X11LIB=/usr/lib || die "emake failed"

	if ! use minimal ; then
		cd "${S}"/gadgets
		emake X11INC=/usr/include X11LIB=/usr/lib || die "emake gadgets failed"
	fi
}

src_install() {
	emake PREFIX=/usr MANPREFIX=/usr/man DESTDIR="${D}" install || die "emake install failed"
	dodoc README || die
	dodoc LICENSE || die

	if ! use minimal ; then
		cd "${S}"/gadgets
		emake PREFIX=/usr MANPREFIX=/usr/man DESTDIR="${D}" install || die "emake gadgets install failed"
		dodoc README* || die
	fi
}
