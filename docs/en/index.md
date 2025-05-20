---
layout: home

hero:
  name: Flutter Element UI
  text: A Flutter UI Component Library Based on Element Plus
  tagline: Simple, Efficient and Beautiful Flutter UI Component Library
  image:
    src: /logo.png
    alt: Flutter Element UI
  actions:
    - theme: brand
      text: Quick Start
      link: /en/guide/quickstart
    - theme: alt
      text: Components
      link: /en/components/
    - theme: alt
      text: View on GitHub
      link: https://github.com/yourusername/flutter_element

features:
  - icon: 🚀
    title: Easy to Use
    details: Provides simple and intuitive APIs for quick adoption
  - icon: 🎨
    title: Design Specification
    details: Follows Element Plus design specifications for consistent visual experience
  - icon: 📱
    title: Cross-platform Support
    details: Supports Android, iOS, Web, Windows, Linux, macOS and more
  - icon: 🛠
    title: Highly Customizable
    details: Rich theme customization options to meet different scenario needs
  - icon: 📦
    title: Rich Components
    details: Provides 40+ high-quality components covering common business scenarios
  - icon: 🌍
    title: Internationalization
    details: Built-in Chinese and English support for easy language switching
---

<script setup>
import { VPTeamMembers } from 'vitepress/theme'

const members = [
  {
    avatar: 'https://github.com/yourusername.png',
    name: 'Your Name',
    title: 'Creator',
    links: [
      { icon: 'github', link: 'https://github.com/yourusername' }
    ]
  }
]
</script>

<VPTeamMembers size="small" :members="members" />
