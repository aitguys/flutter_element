import { DefaultTheme } from "vitepress";

export const zhConfig = {
	title: "Flutter Element UI",
	description:
		"A Flutter UI component library based on Element Plus design system",
	themeConfig: {
		// Navigation bar configuration
		nav: [
			{ text: "首页", link: "/" },
			{ text: "指南", link: "/zh/guide/getting-started" },
			{ text: "组件", link: "/zh/components/" },
		],
		// Sidebar configuration
		sidebar: {
			"/zh/components/": [
				{
					text: "Overview 组件总览",
					items: [{ text: "Overview 组件总览", link: "/zh/components/" }],
				},
				{
					text: "基础组件",
					items: [
						{ text: "Button", link: "/zh/components/button" },

						// { text: 'Input', link: '/zh/components/input' },
						// { text: 'Select', link: '/zh/components/select' },
						// { text: 'Switch', link: '/zh/components/switch' },
						// { text: 'Slider', link: '/zh/components/slider' },
						// { text: 'Rate', link: '/zh/components/rate' },
					],
				},
				{
					text: "表单组件",
					items: [
						{ text: "Input", link: "/zh/components/input" },
						{ text: "Autocomplete", link: "/zh/components/autocomplete" },
						{ text: "Radio", link: "/zh/components/radio" },
						{ text: "Checkbox", link: "/zh/components/checkbox" },
						{ text: "DatePicker", link: "/zh/components/date_picker" },
						{ text: "InputNumber", link: "/zh/components/input_number" },
						{ text: "InputTag", link: "/zh/components/input_tag" },
					],
				},
				// {
				//   text: '数据展示',
				//   items: [
				//     { text: 'Tag', link: '/zh/components/tag' },
				//     { text: 'Progress', link: '/zh/components/progress' },
				//     { text: 'Table', link: '/zh/components/table' },
				//     { text: 'Pagination', link: '/zh/components/pagination' },
				//     { text: 'Timeline', link: '/zh/components/timeline' },
				//     { text: 'Tree', link: '/zh/components/tree' },
				//   ]
				// },
				{
					text: "反馈组件",
					items: [
						{ text: "Dialog", link: "/zh/components/dialog" },
						{ text: "Message", link: "/zh/components/message" },
						// { text: 'Notification', link: '/zh/components/notification' },
						// { text: 'Loading', link: '/zh/components/loading' },
						{ text: "Alert", link: "/zh/components/alert" },
					],
				},
				// {
				//   text: '导航组件',
				//   items: [
				//     { text: 'Menu', link: '/zh/components/menu' },
				//     { text: 'Tabs', link: '/zh/components/tabs' },
				//     { text: 'Breadcrumb', link: '/zh/components/breadcrumb' },
				//     { text: 'Steps', link: '/zh/components/steps' },
				//     { text: 'Dropdown', link: '/zh/components/dropdown' },
				//   ]
				// },
				{
					text: "其他组件",
					items: [
						//     { text: 'Calendar', link: '/zh/components/calendar' },
						{ text: "DatePicker", link: "/zh/components/date_picker" },
						//     { text: 'TimePicker', link: '/zh/components/time-picker' },
						//     { text: 'Upload', link: '/zh/components/upload' },
						//     { text: 'Form', link: '/zh/components/form' },
					],
				},
			],
			"/zh/guide/": [
				{
					text: "指南",
					items: [
						{ text: "快速开始", link: "/zh/guide/getting-started" },
						{ text: "安装", link: "/zh/guide/installation" },
					],
				},
			],
		},
		// Social links

		// Search configuration
	},
} as DefaultTheme.Config;
