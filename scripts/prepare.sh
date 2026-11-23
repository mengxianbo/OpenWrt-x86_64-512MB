#!/bin/sh
set -eu

# 此脚本用于在 OpenWrt 源码树中准备本仓库指定的插件源。
# OpenRung 上游项目目前采用独立 IPK 打包工作流，不是标准 OpenWrt feed；
# 因此这里只固定克隆来源并记录提交，避免把非 Makefile 目录误当作可编译 feed。
if [ ! -d openwrt ]; then
  echo "请在仓库根目录执行，且确保 openwrt/ 源码目录存在。" >&2
  exit 1
fi

git clone --depth 1 https://github.com/mengxianbo/openwrt-openrung.git /tmp/openwrt-openrung
git -C /tmp/openwrt-openrung rev-parse HEAD
