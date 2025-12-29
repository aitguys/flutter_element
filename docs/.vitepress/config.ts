import { defineConfig } from "vitepress";
import { zhConfig } from "../zh/config";
import { enConfig } from "../en/config";

export default defineConfig({
	// 默认语言设置为中文
	lang: "zh-CN",
	// 多语言配置
	themeConfig: {
		// 多语言切换配置
		langMenuLabel: "多语言",
		// 导航栏配置

		// 社交链接
		socialLinks: [
			{
				icon: "github",
				link: "https://github.com/aitguys/flutter_element",
			},
		],
		// 页脚配置

		footer: {
			message: "基于 MIT 协议发布",
			copyright:
				'Copyright © 2024-present Flutter Element UI | <a href="https://beian.miit.gov.cn/" target="_blank">皖ICP备2025087560号</a>',
		},
		search: {
			provider: "local",
			options: {
				translations: {
					button: {
						buttonText: "Search Documentation",
						buttonAriaLabel: "Search Documentation",
					},
					modal: {
						noResultsText: "No results found",
						resetButtonTitle: "Clear search query",
						footer: {
							selectText: "select",
							navigateText: "navigate",
							closeText: "关闭",
						},
					},
				},
			},
		},
	},
	// 其他 VitePress 配置
	title: "Flutter Element UI",
	description: "基于 Element Plus 设计风格的 Flutter UI 组件库",
	lastUpdated: true,
	cleanUrls: true,
	locales: {
		root: {
			label: "简体中文",
			lang: "zh-CN",
			...zhConfig,
		},
		en: {
			label: "English",
			lang: "en-US",
			...enConfig,
		},
	},
	head: [
		[
			"script",
			{},
			`
      var _hmt = _hmt || [];
      (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?515d3e08831eb784a6545b02fa509d48";
        var s = document.getElementsByTagName("script")[0]; 
        s.parentNode.insertBefore(hm, s);
      })();
    `,
		],
	],
	// 重定向配置
	rewrites: {
		// 访问根路径时重定向到中文首页
		"/": "/zh",
		// 访问 /index.html 时重定向到中文首页
		"index.html": "/zh/index.md",
	},
	ignoreDeadLinks: true,
	// 主题配置
});
