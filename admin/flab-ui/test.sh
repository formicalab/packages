#!/bin/sh

# shellcheck shell=busybox

case "$1" in
flab-ui)
	for f in /www/flab/index.html /usr/share/ucode/flab/util.uc \
		/usr/share/ucode/flab/vici.uc \
		/usr/share/ucode/flab/diag-validation.uc \
		/usr/share/ucode/flab/diag-jobs.uc \
		/usr/share/rpcd/acl.d/flab-base.json \
		/usr/share/rpcd/acl.d/flab-diag.json; do
		[ -s "$f" ] || { echo "missing $f" >&2; exit 1; }
	done

	# Every rpcd plugin must at least compile. The shared modules export
	# symbols and cannot be compiled on their own; the import below covers them.
	for f in /usr/share/rpcd/ucode/flab.*.uc; do
		ucode -c -o /dev/null "$f" || exit 1
		echo "compiled $f"
	done

	# Every plugin has an ACL fragment with the package's flab- naming convention.
	for f in /usr/share/rpcd/ucode/flab.*.uc; do
		acl="/usr/share/rpcd/acl.d/$(basename "$f" .uc | tr . -).json"
		[ -s "$acl" ] || { echo "missing $acl for $f" >&2; exit 1; }
	done

	# The shared modules must resolve the way the plugins import them.
	ucode -e 'import { num } from "flab.util"; print("flab.util ", num("7"), "\n");' |
		grep 'flab.util 7'
	;;
esac
