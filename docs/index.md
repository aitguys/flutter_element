---
layout: home

hero:
  name: Flutter Element UI
  text: 基于 Element Plus 的 Flutter UI 组件库
  tagline: 简单、高效、美观的 Flutter UI 组件库
  image:
    src: /logo.png
    alt: Flutter Element UI
  actions:
    - theme: brand
      text: 快速开始
      link: /zh/guide/quickstart
    - theme: alt
      text: 组件列表
      link: /zh/components/
    - theme: alt
      text: 在 GitHub 上查看
      link: https://github.com/yourusername/flutter_element

features:
  - icon: 🚀
    title: 简单易用
    details: 提供简单直观的 API，让您快速上手使用
  - icon: 🎨
    title: 设计规范
    details: 遵循 Element Plus 设计规范，提供一致的视觉体验
  - icon: 📱
    title: 全平台支持
    details: 支持 Android、iOS、Web、Windows、Linux、macOS 等全平台
  - icon: 🛠
    title: 高度可定制
    details: 提供丰富的主题定制选项，满足不同场景需求
  - icon: 📦
    title: 组件丰富
    details: 提供 40+ 高质量组件，覆盖常见业务场景
  - icon: 🌍
    title: 国际化
    details: 内置中英文支持，轻松实现多语言切换
---

<script setup>
import { VPTeamMembers } from 'vitepress/theme'

const members = [
  {
    avatar: 'https://github.com/chenxu2656.png',
    name: 'Colin',
    title: 'Creator',
    links: [
      { icon: 'github', link: 'https://github.com/chenxu2656' }
    ]
  },
   {
    avatar: 'https://github.com/liangjun-fan1.png',
    name: 'Liangjun',
    title: 'Maintainer',
    links: [
      { icon: 'github', link: 'https://github.com/liangjun-fan1' }
    ]
  },
   {
    avatar: 'https://github.com/yongjianyu.png',
    name: 'Yongjian',
    title: 'Maintainer',
    links: [
      { icon: 'github', link: 'https://github.com/yongjianyu' }
    ]
  },
   {
    avatar: 'https://github.com/xiaoyyc.png',
    name: 'YanChao',
    title: 'Maintainer',
    links: [
      { icon: 'github', link: 'https://github.com/xiaoyyc' }
    ]
  }
]
</script>

<VPTeamMembers size="small" :members="members" />
