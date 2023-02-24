# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8..11} )
inherit xdg optfeature python-single-r1

DESCRIPTION="A Wine+Roblox management tool"
HOMEPAGE="https://brinkervii.gitlab.io/grapejuice/"

SRC_URI="https://gitlab.com/brinkervii/grapejuice/-/archive/v${PV}/grapejuice-v${PV}.tar.bz2"
S="${WORKDIR}/grapejuice-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

IUSE="prime pulseaudio wine"
RDEPEND="sys-devel/gettext
	 net-libs/gnutls[abi_x86_32]
	 pulseaudio? ( media-libs/libpulse[abi_x86_32] )
	 >=x11-libs/gtk+-3.24.34
	 x11-libs/cairo
	 x11-misc/xdg-utils
	 x11-misc/xdg-user-dirs
	 x11-misc/shared-mime-info
	 x11-apps/mesa-progs
	 dev-util/gtk-update-icon-cache
	 dev-util/desktop-file-utils
	 dev-libs/openssl[abi_x86_32]
	 dev-libs/gobject-introspection
	 dev-python/pip
	 dev-python/psutil
	 dev-python/click
	 dev-python/requests
	 dev-python/unidecode
	 dev-python/pygobject
	 dev-python/packaging
	 dev-python/setuptools
	 dev-python/pydantic
	 prime? ( x11-apps/xrandr
		x11-misc/prime-run )
	 wine? (
		|| ( app-emulation/wine-staging[abi_x86_32]
		app-emulation/wine-vanilla[abi_x86_32]
		app-emulation/wine-proton[abi_x86_32]
		virtual/wine[abi_x86_32] )
	 )"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/tar"

src_compile() {
	export PYTHONPATH="${S}/src"
	rm "${S}/pyproject.toml"
	${EPYTHON} -m grapejuice_packaging linux_package || die
}

src_install() {
	tar -xvf "${S}"/dist/linux_package/*.tar.gz -C "${D}"
	mkdir -p "${D}/usr/lib/${EPYTHON}"
	mv "${D}/usr/lib/python3/dist-packages" "${D}/usr/lib/${EPYTHON}/site-packages"
	rm -r "${D}/usr/lib/python3"
}

xdg_pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	optfeature "Wine is required to run Roblox, Choose wisely." virtual/wine
	optfeature "Required for PRIME systems running XOrg, where XRandR based profiling is desired" x11-apps/xrandr
}

xdg_pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
