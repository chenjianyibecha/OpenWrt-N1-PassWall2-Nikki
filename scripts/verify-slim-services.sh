#!/usr/bin/env bash
set -euo pipefail
bad='^CONFIG_PACKAGE_(luci-app-(adguardhome|alist|ddns|diskman|filebrowser-go|frpc|hd-idle|homeproxy|momo|nlbwmon|openclash|openvpn|passwall($|[^2])|podman|samba4|ssr-plus|upnp|v2raya|vlmcsd|vsftpd|wireguard|zerotier|nfs)|adguardhome|alist|openlist|samba4-server|ksmbd-server|nfs-kernel-server|openvpn.*|wireguard-tools|zerotier|strongswan.*|vsftpd|vlmcsd|v2raya|podman|docker|dockerd|containerd|runc|miniupnpd|mihomo-alpha)=y$'
required=(
  CONFIG_PACKAGE_luci-app-passwall2=y
  CONFIG_PACKAGE_luci-i18n-passwall2-zh-cn=y
  CONFIG_PACKAGE_luci-app-passwall2_Basic_Core_All=y
  CONFIG_PACKAGE_luci-app-passwall2_Nftables_Transparent_Proxy=y
  CONFIG_PACKAGE_luci-app-passwall2_Iptables_Transparent_Proxy=n
  CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Haproxy=y
  CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Hysteria=y
  CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_NaiveProxy=y
  CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Shadowsocks_Rust_Client=y
  CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Shadowsocks_Rust_Server=y
  CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_ShadowsocksR_Libev_Client=y
  CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_ShadowsocksR_Libev_Server=y
  CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_Simple_Obfs=y
  CONFIG_PACKAGE_luci-app-passwall2_INCLUDE_V2ray_Plugin=y
  CONFIG_PACKAGE_luci-app-nikki=y
  CONFIG_PACKAGE_nikki=y
  CONFIG_PACKAGE_mihomo-meta=y
  CONFIG_PACKAGE_luci-app-mosdns=y
  CONFIG_PACKAGE_mosdns=y
  CONFIG_PACKAGE_luci-app-bandix=y
  CONFIG_PACKAGE_luci-theme-argon=y
  CONFIG_PACKAGE_luci-app-argon-config=y
  CONFIG_PACKAGE_luci-i18n-argon-config-zh-cn=y
  CONFIG_PACKAGE_luci-app-turboacc=y
  CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_OFFLOADING=y
  CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_BBR_CCA=y
  CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_NFT_FULLCONE=y
)
for cfg in scripts/*/config.seed; do
  echo "Checking $cfg"
  for req in "${required[@]}"; do grep -q "^${req}$" "$cfg"; done
  if grep -En "$bad" "$cfg"; then
    echo "Banned service/storage/VPN package selected in $cfg" >&2
    exit 1
  fi
done
for s in scripts/*/zzz-default-settings; do
  if grep -En 'vlmcsd|upnpd|podman|openclash|samba|zerotier|v2raya|homeproxy|momo|ddns|nlbw|containers.conf|storage.conf' "$s"; then
    echo "Banned service default setting remains in $s" >&2
    exit 1
  fi
  grep -q "luci.main.mediaurlbase='/luci-static/argon'" "$s"
done
if grep -RIn 'HiGarfield/cachewrtbuild' .github/workflows; then
  echo "Build cache action must not be used for this full fresh rebuild" >&2
  exit 1
fi
grep -RIn 'clone 26.7.16-1.*passwall2_repo' scripts/*/prepare.sh >/dev/null
grep -RIn 'add_turboacc.sh' scripts/*/prepare.sh >/dev/null
echo 'Plugin policy OK: fresh PassWall2 26.7.16 full core + Nikki + MosDNS + Bandix + Argon CN + Turbo Acc; no cache action.'
