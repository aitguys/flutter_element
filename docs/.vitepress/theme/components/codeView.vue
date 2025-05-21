<template>
	<div class="widget-preview">
		<div class="preview-container">
			<iframe
				:src="previewUrl + props.reviewUrl"
				width="100%"
				:height="height"
				frameborder="0"
				style="border: none"
			></iframe>
			<div class="preview-divider"></div>
			<div class="preview-actions">
				<el-icon
					@click="copyCode"
					style="width: 1em; height: 1em; margin-right: 8px"
					><CopyDocument
				/></el-icon>

				<div class="expand-button" @click="toggleExpanded">
					<span>{{ expanded ? "收起代码" : "查看代码" }}</span>
					<i :class="['expand-icon', expanded ? 'expanded' : '']">▼</i>
				</div>
			</div>
		</div>

		<div v-if="expanded" class="code-container">
			<div v-if="loading" class="loading">
				<div class="spinner"></div>
			</div>
			<div v-else-if="code" class="code-view">
				<pre><code>{{ code }}</code></pre>
			</div>
		</div>
	</div>
</template>

<script setup>
import { ref } from "vue";
import { ElMessage, ElButton, ElTooltip } from "element-plus";
import { Refresh, CopyDocument } from "@element-plus/icons-vue";
const basicCodeRepoUrl =
	"https://raw.githubusercontent.com/aitguys/flutter_element/main/example/lib/pages/";
const previewUrl = "http://localhost:54865/#/";
const props = defineProps({
	reviewUrl: {
		type: String,
		required: true,
	},
	codeUrl: {
		type: String,
		required: true,
	},
	height: {
		type: String,
		default: "220px",
	},
});

const expanded = ref(false);
const loading = ref(false);
const code = ref(null);
const originalCode = ref(null);
const loadCode = async () => {
	loading.value = true;
	try {
		const response = await fetch(basicCodeRepoUrl + props.codeUrl);
		if (response.ok) {
			const text = await response.text();
			code.value = text;
			originalCode.value = text; // 保存原始代码
		} else {
			ElMessage.error("加载代码失败");
		}
	} catch (err) {
		ElMessage.error("加载代码出错");
	} finally {
		loading.value = false;
	}
};

const toggleExpanded = async () => {
	expanded.value = !expanded.value;
	if (expanded.value && !code.value) {
		await loadCode();
	}
};

const copyCode = async () => {
	try {
		await navigator.clipboard.writeText(code.value);
		ElMessage.success("代码已复制");
	} catch (err) {
		ElMessage.error("复制失败");
	}
};

const resetCode = () => {
	code.value = originalCode.value;
	ElMessage.success("代码已重置");
};
</script>

<style scoped>
.widget-preview {
	border: 1px solid #dededf;
	border-radius: 4px;
	margin: 16px 0;
	transition: box-shadow 0.2s;
}

.widget-preview:hover {
	box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.preview-container {
	padding: 24px;
	position: relative;
}
.preview-divider {
	height: 1px;
	background-color: #dededf;
}
.preview-actions {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	padding: 8px 16px;
	border-top: 1px solid var(--el-border-color-light);
	background-color: var(--el-bg-color);
}

.expand-button {
	display: flex;
	align-items: center;
	cursor: pointer;
	color: var(--el-text-color-regular);
	font-size: 14px;
	margin-left: 16px;
}

.expand-icon {
	margin-left: 8px;
	transition: transform 0.3s;
	font-size: 12px;
}

.expand-icon.expanded {
	transform: rotate(180deg);
}

.code-container {
	border-top: 1px solid var(--el-border-color-light);
	background-color: var(--el-bg-color-page);
}

.loading {
	display: flex;
	justify-content: center;
	padding: 20px;
}

.spinner {
	width: 24px;
	height: 24px;
	border: 3px solid #eee;
	border-top-color: #409eff;
	border-radius: 50%;
	animation: spin 1s linear infinite;
}

@keyframes spin {
	to {
		transform: rotate(360deg);
	}
}

.code-view {
	overflow-x: auto;
}

.code-view pre {
	margin: 0;
	padding: 16px;
	font-family: monospace;
}
</style>
