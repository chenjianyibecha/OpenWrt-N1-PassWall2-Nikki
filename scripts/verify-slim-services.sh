#!/usr/bin/env bash
set -euo pipefail
bad='^CONFIG_PACKAGE_(luci-app-(adguardhome|alist|bandix|ddns|diskman|filebrowser-go|frpc|hd-idle|homeproxy|momo|mosdns|nlbwmon|openclash|openvpn|passwall($|[^2])|podman|samba4|ssr-plus|upnp|v2raya|vlmcsd|vsftpd|wireguard|zerotier|nfs)|adguardhome|alist|openlist|mosdns|samba4-server|ksmbd-server|nfs-kernel-server|openvpn.*|wireguard-tools|zerotier|strongswan.*|vsftpd|vlmcsd|v2raya|podman|docker|dockerd|containerd|runc|miniupnpd)=y$'
for cfg in scripts/*/config.seed; do
  echo "Checking $cfg"
  grep -q '^CONFIG_PACKAGE_luci-app-passwall2=y$' "$cfg"
  grep -q '^CONFIG_PACKAGE_luci-i18n-passwall2-zh-cn=y$' "$cfg"
  grep -q '^CONFIG_PACKAGE_luci-app-nikki=y$' "$cfg"
  grep -q '^CONFIG_PACKAGE_nikki=y$' "$cfg"
  grep -q '^CONFIG_PACKAGE_mihomo-meta=y$' "$cfg"
  if grep -En "$bad" "$cfg"; then
    echo "Banned service/storage/VPN package selected in $cfg" >&2
    exit 1
  fi
done
for s in scripts/*/zzz-default-settings; do
  if grep -En 'mosdns|vlmcsd|upnpd|podman|openclash|samba|zerotier|v2raya|homeproxy|momo|ddns|nlbw' "$s"; then
    echo "Banned service default setting remains in $s" >&2
    exit 1
  fi
done
echo 'Slim Services policy OK: PassWall2 + Nikki only.'
