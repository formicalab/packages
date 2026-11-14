#
# Copyright (C) 2026 Marcello Formica
#
# This is free software, licensed under the MIT License.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=flab-ui
PKG_VERSION:=0.1.8
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/formicalab/flab-ui/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=de6674d5d5ff46051d5b30500b37451fa28aac00d0a09cc1bf9a5d111a0f120b

PKG_MAINTAINER:=Marcello Formica <formicalab@live.it>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE www/LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/flab-ui
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=Lightweight web administration UI
  URL:=https://github.com/formicalab/flab-ui
  DEPENDS:=+rpcd +rpcd-mod-ucode +ucode +ucode-mod-fs +ucode-mod-ubus \
	+ucode-mod-uci +ucode-mod-uloop +uhttpd +uhttpd-mod-ubus
  PKGARCH:=all
endef

define Package/flab-ui/description
  A lightweight administration web UI for OpenWrt. A static single-page app served
  by uhttpd at /flab/ that talks to the router through the ubus JSON-RPC
  endpoint and a set of rpcd ucode plugins. It shows the state of wired
  and wireless networks, firewall, routing, IPsec, WireGuard, DHCP, DNS,
  traffic and services, and edits their UCI configuration with an automatic
  rollback. Sign in with the router's root login.
endef

# rpcd only reads its plugins and ACL fragments when it starts or reloads.
define Package/flab-ui/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || /etc/init.d/rpcd reload
exit 0
endef

define Package/flab-ui/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || /etc/init.d/rpcd reload
exit 0
endef

define Build/Compile
endef

define Package/flab-ui/install
	$(INSTALL_DIR) $(1)/www/flab
	$(CP) $(PKG_BUILD_DIR)/www/. $(1)/www/flab/
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/rpcd/acl.d/*.json \
		$(1)/usr/share/rpcd/acl.d/
	$(INSTALL_DIR) $(1)/usr/share/rpcd/ucode
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/rpcd/ucode/*.uc \
		$(1)/usr/share/rpcd/ucode/
	$(INSTALL_DIR) $(1)/usr/share/ucode/flab
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/rpcd/lib/flab/*.uc \
		$(1)/usr/share/ucode/flab/
endef

$(eval $(call BuildPackage,flab-ui))
