# OpenWrt x86_64 512MB 定制固件

基于 OpenWrt 官方源码的 x86_64 自动编译项目。通过 GitHub Actions 自动拉取插件源码、编译固件、整理校验文件，并在构建成功后自动发布 GitHub Releases。

## 固件目标

- 架构：x86_64 / x86_64 generic
- 固件版本：OpenWrt 24.10.3（可在工作流中调整）
- 软件包可写空间规划：512MB（不是内存/RAM限制）
- 输出：x86_64 combined 镜像（BIOS/传统启动）与 EFI 镜像（UEFI，若上游目标提供）
- 自动构建：GitHub Actions
- 自动发布：GitHub Releases

## 内置插件

| 插件 | 说明 |
|---|---|
| Passwall | 固定使用上游版本 `25.4.1`，LuCI 与核心依赖均锁定到对应历史提交 |
| AdGuardHome | DNS 广告与跟踪器过滤 |
| OpenRung | 使用本账号维护的 OpenRung OpenWrt 打包项目 |
| DDNS-GO | 动态域名解析 |
| MosDNS | DNS 分流与解析 |
| WeChatPush | 微信推送 |

另外保留系统基础 LuCI、防火墙、网络管理和常用诊断工具。微信推送包在 feed 中的实际包名为 `luci-app-serverchan`，界面功能为微信/Server酱推送。

### 明确排除

- Lucky / luci-app-lucky
- WebRTC 相关软件包

## 编译方式

1. 打开本仓库的 **Actions**。
2. 选择 **编译 OpenWrt x86_64 512MB**。
3. 点击 **Run workflow**。
4. 等待任务完成。
5. 固件成功后打开 **Releases** 下载固件、插件 IPK 和 SHA256 校验文件。OpenRung IPK 由单独的 **编译 OpenRung 插件 IPK** 工作流构建并发布。

也支持向 main 分支推送工作流、配置或脚本变更后自动触发编译。

## 512MB 空间说明

工作流将 x86_64 根文件系统分区参数设为 512MB。它表示固件根文件系统/可写空间的规划值，不是设备 RAM 大小，也不意味着压缩后的固件文件只有 512MB。实际可用空间会受镜像格式、文件系统元数据、内核和已安装软件包占用影响。

建议设备至少具备 1GB RAM；如果要运行较多代理核心、DNS 服务和规则库，建议使用更充足的存储空间。

## Passwall 版本核验

Passwall 固定使用上游 **25.4.1**，不跟随上游 `main` 自动升级：

- LuCI 主程序提交：[`0799261a542e55bb4bbf6dac85803e22e344f7a2`](https://github.com/Openwrt-Passwall/openwrt-passwall/commit/0799261a542e55bb4bbf6dac85803e22e344f7a2)
- 配套核心依赖提交：[`cd668cd468db68a6e5aad6d32f19ff7bd73a59e2`](https://github.com/Openwrt-Passwall/openwrt-passwall-packages/commit/cd668cd468db68a6e5aad6d32f19ff7bd73a59e2)

工作流会核验 LuCI Makefile 中的 `PKG_VERSION:=25.4.1`，并核对两个源码提交 SHA。任何版本或提交不匹配都会停止构建，避免意外编译成新版。

## 手动触发参数

工作流支持选择 OpenWrt 源码版本、是否清理缓存，以及是否发布 Release。默认使用 OpenWrt 24.10.3，并在成功后发布。

## 目录结构

```
.
├── .github/workflows/build.yml
├── config/seed.config
├── scripts/prepare.sh
└── README.md
```

## 免责声明

本仓库仅负责自动化集成与构建。各插件及其依赖由对应上游项目维护，版权和许可证以各自仓库为准。请遵守当地法律法规及上游项目许可证。
