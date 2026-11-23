#!/bin/sh

# shellcheck shell=busybox

compile() {
	ucode -c -o /dev/null "$1" || exit 1
	echo "compiled $1"
}

acl_pair() {
	acl="/usr/share/rpcd/acl.d/$(basename "$1" .uc | tr . -).json"
	[ -s "$acl" ] || { echo "missing $acl for $1" >&2; exit 1; }
}

case "$1" in
flab-ui-base)
	for f in /www/flab/index.html /www/flab/js/core/ubus.js \
		/usr/share/ucode/flab/util.uc /usr/share/ucode/flab/exec.uc; do
		[ -s "$f" ] || { echo "missing $f" >&2; exit 1; }
	done
	compile /usr/share/rpcd/ucode/flab.system.uc
	compile /usr/share/rpcd/ucode/flab.sensors.uc
	acl_pair /usr/share/rpcd/ucode/flab.system.uc
	acl_pair /usr/share/rpcd/ucode/flab.sensors.uc
	;;
flab-ui-mod-network)
	[ -s /www/flab/modules/network.json ] || exit 1
	compile /usr/share/rpcd/ucode/flab.network.uc
	acl_pair /usr/share/rpcd/ucode/flab.network.uc
	;;
flab-ui-mod-wireless)
	[ -s /www/flab/modules/wireless.json ] || exit 1
	for plugin in radio wifi mesh; do
		compile "/usr/share/rpcd/ucode/flab.$plugin.uc"
		acl_pair "/usr/share/rpcd/ucode/flab.$plugin.uc"
	done
	;;
flab-ui-mod-firewall)
	[ -s /www/flab/modules/firewall.json ] || exit 1
	compile /usr/share/rpcd/ucode/flab.firewall.uc
	acl_pair /usr/share/rpcd/ucode/flab.firewall.uc
	;;
flab-ui-mod-vpn)
	[ -s /www/flab/modules/vpn.json ] || exit 1
	for plugin in ipsec wireguard; do
		compile "/usr/share/rpcd/ucode/flab.$plugin.uc"
		acl_pair "/usr/share/rpcd/ucode/flab.$plugin.uc"
	done
	;;
flab-ui-mod-dhcp)
	[ -s /www/flab/modules/dhcp.json ] || exit 1
	[ -s /usr/share/rpcd/acl.d/flab-dhcp.json ] || exit 1
	;;
flab-ui-mod-dns)
	[ -s /www/flab/modules/dns.json ] || exit 1
	for plugin in dns ddns; do
		compile "/usr/share/rpcd/ucode/flab.$plugin.uc"
		acl_pair "/usr/share/rpcd/ucode/flab.$plugin.uc"
	done
	;;
flab-ui-mod-routing)
	[ -s /www/flab/modules/routing.json ] || exit 1
	for plugin in routing bgp; do
		compile "/usr/share/rpcd/ucode/flab.$plugin.uc"
		acl_pair "/usr/share/rpcd/ucode/flab.$plugin.uc"
	done
	;;
flab-ui-mod-traffic)
	[ -s /www/flab/modules/traffic.json ] || exit 1
	compile /usr/share/rpcd/ucode/flab.traffic.uc
	acl_pair /usr/share/rpcd/ucode/flab.traffic.uc
	;;
flab-ui-mod-toolbox)
	[ -s /www/flab/modules/toolbox.json ] || exit 1
	for f in /www/flab/index.html /usr/share/ucode/flab/util.uc \
		/usr/share/ucode/flab/vici.uc \
		/usr/share/ucode/flab/diag-validation.uc \
		/usr/share/ucode/flab/diag-jobs.uc \
		/usr/share/rpcd/acl.d/flab-base.json \
		/usr/share/rpcd/acl.d/flab-diag.json; do
		[ -s "$f" ] || { echo "missing $f" >&2; exit 1; }
	done

	compile /usr/share/rpcd/ucode/flab.diag.uc
	acl_pair /usr/share/rpcd/ucode/flab.diag.uc
	;;
flab-ui-mod-services)
	[ -s /www/flab/modules/services.json ] || exit 1
	compile /usr/share/rpcd/ucode/flab.services.uc
	acl_pair /usr/share/rpcd/ucode/flab.services.uc
	;;
flab-ui-mod-logs)
	[ -s /www/flab/modules/logs.json ] || exit 1
	compile /usr/share/rpcd/ucode/flab.logs.uc
	acl_pair /usr/share/rpcd/ucode/flab.logs.uc
	;;
flab-ui-mod-asterisk)
	[ -s /www/flab/modules/asterisk.json ] || exit 1
	compile /usr/share/rpcd/ucode/flab.asterisk.uc
	acl_pair /usr/share/rpcd/ucode/flab.asterisk.uc
	;;
flab-ui)
	# The metapackage's dependencies provide every module.
	ucode -e 'import { num } from "flab.util"; print("flab.util ", num("7"), "\n");' |
		grep 'flab.util 7'
	;;
esac
