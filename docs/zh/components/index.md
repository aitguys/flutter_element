# 组件总览

Flutter Element UI 为开发者提供了丰富的基础组件，能够满足大部分业务场景的需求。

## 基础组件
提供了最基础的组件，是构建用户界面的基本单元。

<div class="component-block">
  <div class="component-item">
    <a href="./button">
      <div class="component-icon">🔘</div>
      <div class="component-name">Button 按钮</div>
    </a>
  </div>
  <div class="component-item">
    <a href="./input">
      <div class="component-icon">📝</div>
      <div class="component-name">Input 输入框</div>
    </a>
  </div>
  <!-- 其他基础组件 -->
</div>

## 数据展示
用于展示数据的各类组件。

<div class="component-block">
  <div class="component-item">
    <a href="./table">
      <div class="component-icon">📊</div>
      <div class="component-name">Table 表格</div>
    </a>
  </div>
  <div class="component-item">
    <a href="./tag">
      <div class="component-icon">🏷️</div>
      <div class="component-name">Tag 标签</div>
    </a>
  </div>
  <!-- 其他数据展示组件 -->
</div>

## 反馈组件
用于向用户反馈信息的组件。

<div class="component-block">
  <div class="component-item">
    <a href="./dialog">
      <div class="component-icon">💬</div>
      <div class="component-name">Dialog 对话框</div>
    </a>
  </div>
  <div class="component-item">
    <a href="./message">
      <div class="component-icon">📢</div>
      <div class="component-name">Message 消息提示</div>
    </a>
  </div>
  <!-- 其他反馈组件 -->
</div>

## 导航组件
提供导航功能的组件。

<div class="component-block">
  <div class="component-item">
    <a href="./menu">
      <div class="component-icon">📋</div>
      <div class="component-name">Menu 菜单</div>
    </a>
  </div>
  <div class="component-item">
    <a href="./tabs">
      <div class="component-icon">📑</div>
      <div class="component-name">Tabs 标签页</div>
    </a>
  </div>
  <!-- 其他导航组件 -->
</div>

## 其他组件
其他功能性组件。

<div class="component-block">
  <div class="component-item">
    <a href="./calendar">
      <div class="component-icon">📅</div>
      <div class="component-name">Calendar 日历</div>
    </a>
  </div>
  <div class="component-item">
    <a href="./form">
      <div class="component-icon">📝</div>
      <div class="component-name">Form 表单</div>
    </a>
  </div>
  <!-- 其他组件 -->
</div>

<style>
.component-block {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
  gap: 1rem;
  padding: 1rem 0;
}

.component-item {
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  padding: 1rem;
  text-align: center;
  transition: all 0.3s;
}

.component-item:hover {
  border-color: #409eff;
  transform: translateY(-2px);
}

.component-icon {
  font-size: 24px;
  margin-bottom: 8px;
}

.component-name {
  font-size: 14px;
  color: #606266;
}

a {
  text-decoration: none;
}
</style>
