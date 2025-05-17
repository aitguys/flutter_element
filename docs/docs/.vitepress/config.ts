import { defineConfig } from "vitepress";

// refer https://vitepress.dev/reference/site-config for details
export default defineConfig({
	lang: "zh-CN",
	title: "Flutter Element",
	description: "基于 Material Design 的 Flutter 组件库",

	locales: {
		root: {
			label: "简体中文",
			lang: "zh-CN",
		},
		en: {
			label: "English",
			lang: "en-US",
		},
	},

	themeConfig: {
		logo: "/logo.svg",

		nav: [
			{
				text: "指南",
				link: "/guide/getting-started",
			},
			{
				text: "组件",
				link: "/components/",
			},
			{
				text: "🌐 语言",
				items: [
					{ text: "简体中文", link: "/" },
					{ text: "English", link: "/en/" },
				],
			},
		],

		sidebar: {
			// 中文侧边栏
			"/guide/": [
				{
					text: "入门",
					items: [
						{ text: "快速开始", link: "/guide/getting-started" },
						{ text: "安装", link: "/guide/installation" },
					],
				},
			],
			"/components/": [
				{
					text: "基础组件",
					items: [
						{ text: "Button 按钮", link: "/components/button" },
						{ text: "Input 输入框", link: "/components/input" },
					],
				},
			],
			// 英文侧边栏
			"/en/guide/": [
				{
					text: "Getting Started",
					items: [
						{ text: "Quick Start", link: "/en/guide/getting-started" },
						{ text: "Installation", link: "/en/guide/installation" },
					],
				},
			],
			"/en/components/": [
				{
					text: "Basic Components",
					items: [
						{ text: "Button", link: "/en/components/button" },
						{ text: "Input", link: "/en/components/input" },
					],
				},
			],
		},

		socialLinks: [
			{ icon: "github", link: "https://github.com/your-repo/flutter-element" },
		],
	},

});
