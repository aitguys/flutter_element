import DefaultTheme from "vitepress/theme";
import type { Theme } from 'vitepress'
import "./custom.css";
import CodeView from "./components/codeView.vue";
export default {
    extends: DefaultTheme,
    enhanceApp({ app }) {
      // 注册自定义全局组件
      app.component('CodeView', CodeView /* ... */)
    }
  }  satisfies Theme
  
