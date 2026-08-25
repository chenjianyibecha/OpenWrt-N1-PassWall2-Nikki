# OpenWrt N1 — PassWall2 + Nikki slim build

基于 `ffuqiangg/build_openwrt` 的 GitHub Actions 编译工程，目标设备为斐讯 N1 / S905D。

## 定制目标

- 服务插件只保留：`luci-app-passwall2`、`luci-app-nikki`。
- Nikki 选择 `mihomo-meta`，移除 `mihomo-alpha`。
- 删除/禁用无用服务、网络存储、VPN 和代理旧插件：OpenClash、SSR Plus、PassWall v1、Momo、HomeProxy、MosDNS、AdGuardHome、Alist/OpenList、Samba/NFS/ksmbd/vsftpd、ZeroTier、OpenVPN、WireGuard、StrongSwan/IPSec、UPnP、v2rayA、Podman、KMS/vlmcsd、DDNS、nlbwmon 等。
- 保留 N1 固件编译和 Amlogic 打包 workflow。

## 使用

在 GitHub Actions 手动运行需要的 workflow：

- `OpenWrt`：OpenWrt armsr/armv8 rootfs + Amlogic 打包。
- `ImmortalWrt` / `LEDE` / `iStoreOS`：保留原项目对应编译入口，但配置已套用同样的服务精简策略。

每个 workflow 在编译前会运行：

```bash
bash scripts/verify-slim-services.sh
```

该检查会阻止被禁用的服务/网络存储/VPN 插件重新进入配置。

## 默认信息

- 默认 IP：`192.168.1.99`
- 默认密码：`password`

## 上游

- 原始工程：https://github.com/ffuqiangg/build_openwrt
- 打包方案：Ophub / amlogic-s9xxx-openwrt 系列
