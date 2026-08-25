# OpenWrt N1 — PassWall2 26.7.16 + Nikki + MosDNS + Bandix

基于 `ffuqiangg/build_openwrt` 的 GitHub Actions 编译工程，目标设备为斐讯 N1 / S905D。

## 当前定制目标

- 重新拉取源码编译，不使用 `HiGarfield/cachewrtbuild` 编译缓存 action。
- PassWall2 固定使用 `OpenWrt-Passwall/openwrt-passwall2` tag `26.7.16-1`，即中文版本 `26.7.16`。
- PassWall2 使用全核心/完整组件配置：Xray + SingBox、nftables transparent proxy（禁用 iptables legacy 透明代理以避免 apk 中 iptables-nft 与 iptables-zz-legacy 冲突）、Haproxy、Hysteria、NaiveProxy、Shadowsocks Rust Client/Server、ShadowsocksR Libev Client/Server、Simple-Obfs、V2ray-Plugin。
- Nikki 保留并使用 `mihomo-meta`，禁用 `mihomo-alpha`。
- 恢复：MosDNS、Bandix。
- 加入中文 Argon：`luci-theme-argon`、`luci-app-argon-config`、`luci-i18n-argon-config-zh-cn`，默认 LuCI 主题设为 Argon，语言设为中文。
- 继续禁用无用服务、网络存储、VPN 和旧代理插件：OpenClash、SSR Plus、PassWall v1、Momo、HomeProxy、AdGuardHome、Alist/OpenList、Samba/NFS/ksmbd/vsftpd、ZeroTier、OpenVPN、WireGuard、StrongSwan/IPSec、UPnP、v2rayA、Podman、KMS/vlmcsd、DDNS、nlbwmon、Diskman/Filebrowser 等。

## 使用

在 GitHub Actions 手动运行 `OpenWrt` workflow。编译前会运行：

```bash
bash scripts/verify-slim-services.sh
```

该检查会阻止缓存 action、错误 PassWall2 配置、无用服务/网络存储/VPN 插件重新进入配置。

## 默认信息

- 默认 IP：`192.168.1.99`
- 默认密码：`password`

## 上游

- 原始工程：https://github.com/ffuqiangg/build_openwrt
- PassWall2：https://github.com/OpenWrt-Passwall/openwrt-passwall2
- PassWall packages：https://github.com/OpenWrt-Passwall/openwrt-passwall-packages
