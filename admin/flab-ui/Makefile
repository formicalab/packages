#
# Copyright (C) 2026 Marcello Formica
#
# This is free software, licensed under the MIT License.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=flab-ui
PKG_VERSION:=0.1.26
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/formicalab/flab-ui/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=f7846c155f89be6ef3410a53851adaf54369cf87142964332c3420dc4125cca4

PKG_MAINTAINER:=Marcello Formica <formicalab@live.it>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE www/LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/flab-ui/Default
  SECTION:=admin
  CATEGORY:=Administration
  URL:=https://github.com/formicalab/flab-ui
  PKGARCH:=all
endef

define Package/flab-ui-base
  $(Package/flab-ui/Default)
  TITLE:=Flab UI base shell and system status
  DEPENDS:=+rpcd +rpcd-mod-ucode +ucode +ucode-mod-fs +ucode-mod-ubus \
	+ucode-mod-uci +ucode-mod-uloop +uhttpd +uhttpd-mod-ubus
endef

define Package/flab-ui-base/description
  Base shell, session handling, shared assets, Overview and System settings for
  flab-ui. Optional feature modules add pages and their rpcd plugins.
endef

define Package/flab-ui-mod-network
  $(Package/flab-ui/Default)
  TITLE:=Flab UI network module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-network/description
  Ethernet ports, VLANs, Devices and Interfaces and connected clients for
  flab-ui.
endef

define Package/flab-ui-mod-wireless
  $(Package/flab-ui/Default)
  TITLE:=Flab UI wireless module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-wireless/description
  Wi-Fi radio, access point, client network and mesh views and configuration.
endef

define Package/flab-ui-mod-firewall
  $(Package/flab-ui/Default)
  TITLE:=Flab UI firewall module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-firewall/description
  Firewall zones, policies, rules, port forwards and live nftables counters.
endef

define Package/flab-ui-mod-vpn
  $(Package/flab-ui/Default)
  TITLE:=Flab UI VPN module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-vpn/description
  IPsec and WireGuard status and configuration for flab-ui.
endef

define Package/flab-ui-mod-dhcp
  $(Package/flab-ui/Default)
  TITLE:=Flab UI DHCP module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-dhcp/description
  DHCP, reservations, pools, router advertisements and network boot settings.
endef

define Package/flab-ui-mod-dns
  $(Package/flab-ui/Default)
  TITLE:=Flab UI DNS module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-dns/description
  DNS resolver, zones and Dynamic DNS status and configuration.
endef

define Package/flab-ui-mod-routing
  $(Package/flab-ui/Default)
  TITLE:=Flab UI routing module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-routing/description
  Kernel routing, policy rules, static routes, lookups and optional BGP.
endef

define Package/flab-ui-mod-asterisk
  $(Package/flab-ui/Default)
  TITLE:=Flab UI Asterisk module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-asterisk/description
  Read-only view of the Asterisk PBX: daemon status, PJSIP registrations and
  endpoints, the dialplan and the configuration files. Needs asterisk with
  PJSIP installed to show anything.
endef

define Package/flab-ui-mod-traffic
  $(Package/flab-ui/Default)
  TITLE:=Flab UI traffic module
  DEPENDS:=+flab-ui-base +flab-ui-mod-network
endef

define Package/flab-ui-mod-traffic/description
  Live traffic, connection tracking and nlbwmon accounting views.
endef

define Package/flab-ui-mod-toolbox
  $(Package/flab-ui/Default)
  TITLE:=Flab UI toolbox module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-toolbox/description
  Ping, traceroute, mtr, DNS and TLS diagnostics, packet capture, iperf3 and
  Wake-on-LAN.
endef

define Package/flab-ui-mod-services
  $(Package/flab-ui/Default)
  TITLE:=Flab UI services module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-services/description
  View and control OpenWrt init services.
endef

define Package/flab-ui-mod-logs
  $(Package/flab-ui/Default)
  TITLE:=Flab UI logs module
  DEPENDS:=+flab-ui-base
endef

define Package/flab-ui-mod-logs/description
  System and kernel logs with filtering and secret redaction.
endef

define Package/flab-ui
  $(Package/flab-ui/Default)
  TITLE:=Lightweight web administration UI (all modules)
  DEPENDS:=+flab-ui-base +flab-ui-mod-network +flab-ui-mod-wireless \
	+flab-ui-mod-firewall +flab-ui-mod-vpn +flab-ui-mod-dhcp +flab-ui-mod-dns \
	+flab-ui-mod-routing +flab-ui-mod-traffic +flab-ui-mod-toolbox \
	+flab-ui-mod-services +flab-ui-mod-logs +flab-ui-mod-asterisk
endef

define Package/flab-ui/description
  Complete flab-ui installation. Install flab-ui-base and selected feature
  modules instead when a smaller administration UI is preferred.
endef

# Installing or removing a backend package changes what rpcd should serve.
define Package/flab-ui/restart
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || /etc/init.d/rpcd restart
exit 0
endef

Package/flab-ui-base/postinst = $(Package/flab-ui/restart)
Package/flab-ui-base/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-network/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-network/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-wireless/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-wireless/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-firewall/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-firewall/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-vpn/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-vpn/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-dhcp/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-dhcp/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-dns/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-dns/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-routing/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-routing/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-traffic/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-traffic/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-toolbox/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-toolbox/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-services/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-services/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-logs/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-logs/postrm = $(Package/flab-ui/restart)
Package/flab-ui-mod-asterisk/postinst = $(Package/flab-ui/restart)
Package/flab-ui-mod-asterisk/postrm = $(Package/flab-ui/restart)

define Build/Compile
endef

define Package/flab-ui-base/install
	$(INSTALL_DIR) $(1)/www/flab/js/core $(1)/www/flab/js/pages/overview \
		$(1)/www/flab/js/pages/settings $(1)/www/flab/css $(1)/www/flab/vendor \
		$(1)/www/flab/modules
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/index.html $(1)/www/flab/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/LICENSE $(1)/www/flab/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/js/main.js $(1)/www/flab/js/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/js/core/*.js $(1)/www/flab/js/core/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/js/pages/index.js $(1)/www/flab/js/pages/
	$(CP) $(PKG_BUILD_DIR)/www/js/pages/overview/. $(1)/www/flab/js/pages/overview/
	$(CP) $(PKG_BUILD_DIR)/www/js/pages/settings/. $(1)/www/flab/js/pages/settings/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/css/base.css \
		$(PKG_BUILD_DIR)/www/css/forms.css $(PKG_BUILD_DIR)/www/css/drawer.css \
		$(PKG_BUILD_DIR)/www/css/overview.css $(PKG_BUILD_DIR)/www/css/settings.css \
		$(PKG_BUILD_DIR)/www/css/routing.css $(1)/www/flab/css/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/vendor/* $(1)/www/flab/vendor/
	$(INSTALL_DIR) $(1)/usr/share/rpcd/ucode $(1)/usr/share/ucode/flab \
		$(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/rpcd/ucode/flab.system.uc \
		$(PKG_BUILD_DIR)/rpcd/ucode/flab.sensors.uc $(1)/usr/share/rpcd/ucode/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/rpcd/lib/flab/*.uc $(1)/usr/share/ucode/flab/
	$(INSTALL_DATA) ./files/usr/share/rpcd/acl.d/flab-base.json \
		./files/usr/share/rpcd/acl.d/flab-system.json \
		./files/usr/share/rpcd/acl.d/flab-sensors.json \
		./files/usr/share/rpcd/acl.d/flab-settings.json \
		$(1)/usr/share/rpcd/acl.d/
endef

define Install/FlabFrontend
	$(INSTALL_DIR) $(1)/www/flab/js/pages $(1)/www/flab/css $(1)/www/flab/modules
	$(CP) $(foreach d,$(2),$(PKG_BUILD_DIR)/www/js/pages/$(d)) $(1)/www/flab/js/pages/
	$(INSTALL_DATA) $(foreach f,$(3),$(PKG_BUILD_DIR)/www/css/$(f)) $(1)/www/flab/css/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www/modules/$(4).json $(1)/www/flab/modules/
endef

define Install/FlabBackend
	$(INSTALL_DIR) $(1)/usr/share/rpcd/ucode $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) $(foreach p,$(2),$(PKG_BUILD_DIR)/rpcd/ucode/flab.$(p).uc) $(1)/usr/share/rpcd/ucode/
	$(INSTALL_DATA) $(foreach a,$(3),./files/usr/share/rpcd/acl.d/flab-$(a).json) $(1)/usr/share/rpcd/acl.d/
endef

define Package/flab-ui-mod-network/install
	$(call Install/FlabFrontend,$(1),network interfaces connected,network.css connected.css netedit.css board.css,network)
	$(call Install/FlabBackend,$(1),network,network vlan)
endef

define Package/flab-ui-mod-wireless/install
	$(call Install/FlabFrontend,$(1),radios wifi,radios.css wifi.css,wireless)
	$(call Install/FlabBackend,$(1),radio wifi mesh,radio wifi mesh)
endef

define Package/flab-ui-mod-firewall/install
	$(call Install/FlabFrontend,$(1),firewall,firewall.css,firewall)
	$(call Install/FlabBackend,$(1),firewall,firewall)
endef

define Package/flab-ui-mod-vpn/install
	$(call Install/FlabFrontend,$(1),ipsec wireguard,ipsec.css wireguard.css,vpn)
	$(call Install/FlabBackend,$(1),ipsec wireguard,ipsec wireguard)
endef

define Package/flab-ui-mod-dhcp/install
	$(call Install/FlabFrontend,$(1),dhcp,dhcp.css,dhcp)
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./files/usr/share/rpcd/acl.d/flab-dhcp.json $(1)/usr/share/rpcd/acl.d/
endef

define Package/flab-ui-mod-dns/install
	$(call Install/FlabFrontend,$(1),dns ddns,dns.css ddns.css,dns)
	$(call Install/FlabBackend,$(1),dns ddns,dns ddns)
endef

define Package/flab-ui-mod-routing/install
	$(call Install/FlabFrontend,$(1),routing,bgp.css,routing)
	$(call Install/FlabBackend,$(1),routing bgp,routing bgp)
endef

define Package/flab-ui-mod-traffic/install
	$(call Install/FlabFrontend,$(1),traffic,traffic.css,traffic)
	$(call Install/FlabBackend,$(1),traffic,traffic)
endef

define Package/flab-ui-mod-toolbox/install
	$(call Install/FlabFrontend,$(1),toolbox,toolbox.css,toolbox)
	$(call Install/FlabBackend,$(1),diag,diag)
endef

define Package/flab-ui-mod-services/install
	$(call Install/FlabFrontend,$(1),services,services.css,services)
	$(call Install/FlabBackend,$(1),services,services)
endef

define Package/flab-ui-mod-logs/install
	$(call Install/FlabFrontend,$(1),logs,logs.css,logs)
	$(call Install/FlabBackend,$(1),logs,logs)
endef

define Package/flab-ui-mod-asterisk/install
	$(call Install/FlabFrontend,$(1),asterisk,asterisk.css drawer.css,asterisk)
	$(call Install/FlabBackend,$(1),asterisk,asterisk)
endef

define Package/flab-ui/install
	$(INSTALL_DIR) $(1)/usr/share/flab-ui
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/LICENSE $(1)/usr/share/flab-ui/FULL
endef

$(eval $(call BuildPackage,flab-ui-base))
$(eval $(call BuildPackage,flab-ui-mod-network))
$(eval $(call BuildPackage,flab-ui-mod-wireless))
$(eval $(call BuildPackage,flab-ui-mod-firewall))
$(eval $(call BuildPackage,flab-ui-mod-vpn))
$(eval $(call BuildPackage,flab-ui-mod-dhcp))
$(eval $(call BuildPackage,flab-ui-mod-dns))
$(eval $(call BuildPackage,flab-ui-mod-routing))
$(eval $(call BuildPackage,flab-ui-mod-traffic))
$(eval $(call BuildPackage,flab-ui-mod-toolbox))
$(eval $(call BuildPackage,flab-ui-mod-services))
$(eval $(call BuildPackage,flab-ui-mod-logs))
$(eval $(call BuildPackage,flab-ui-mod-asterisk))
$(eval $(call BuildPackage,flab-ui))
