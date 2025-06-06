# Progress 进度条

用于展示操作进度，告知用户当前状态和预期。

## 实现原理

使用 Stack、Container、LinearProgressIndicator、CircularProgressIndicator 等组件实现进度条的展示效果。

## 基础用法

使用 `percentage` 属性来设置进度条的百分比。

<CodeView
  codeUrl="progress_page/progress_basic.dart"
  reviewUrl="progress/basic"
  height="300px"
/>

## 进度条内显示百分比标识

使用 `textInside` 属性来在进度条内显示百分比标识。

<CodeView
  codeUrl="progress_page/progress_text_inside.dart"
  reviewUrl="progress/text_inside"
  height="300px"
/>

## 自定义颜色

使用 `color` 或 `colorType` 属性来自定义进度条的颜色。

<CodeView
  codeUrl="progress_page/progress_custom_color.dart"
  reviewUrl="progress/custom_color"
  height="300px"
/>

## 环形进度条

使用 `type` 属性来指定使用环形进度条，通过 `width` 属性来设置其大小。

<CodeView
  codeUrl="progress_page/progress_circle.dart"
  reviewUrl="progress/circle"
  height="300px"
/>

## 动画进度条

使用 `indeterminate` 属性来显示动画进度条，通过 `duration` 属性来控制动画速度。

<CodeView
  codeUrl="progress_page/progress_animated.dart"
  reviewUrl="progress/animated"
  height="300px"
/>

## 条纹进度条

使用 `striped` 属性来显示条纹进度条，通过 `stripedFlow` 属性来使条纹流动起来，使用 `duration` 属性来控制条纹流动的速度。

<CodeView
  codeUrl="progress_page/progress_striped.dart"
  reviewUrl="progress/striped"
  height="300px"
/>

## API

### Progress 属性

| 属性名        | 说明                                                  | 类型                                 | 默认值               |
| ------------- | ----------------------------------------------------- | ------------------------------------ | -------------------- |
| percentage    | 百分比，必填                                          | `double`                             | -                    |
| type          | 进度条类型                                            | `EProgressType`                      | `EProgressType.line` |
| strokeWidth   | 进度条的宽度                                          | `double`                             | `6.0`                |
| textInside    | 进度条显示文字内置在进度条内（只在 type=line 时可用） | `boolean`                            | `false`              |
| showText      | 是否显示进度条文字内容                                | `boolean`                            | `true`               |
| color         | 进度条背景色                                          | `Color`                              | -                    |
| colorType     | 进度条类型                                            | `EColorType`                         | `EColorType.primary` |
| width         | 环形进度条画布宽度（只在 type=circle 时可用）         | `double`                             | `126.0`              |
| indeterminate | 是否为动画进度条                                      | `boolean`                            | `false`              |
| duration      | 控制动画速度（秒）                                    | `double`                             | `3.0`                |
| striped       | 是否显示条纹                                          | `boolean`                            | `false`              |
| stripedFlow   | 条纹是否具有流动效果                                  | `boolean`                            | `false`              |
| customBuilder | 自定义进度条文字内容                                  | `Widget Function(double percentage)` | -                    |

### Progress 类型

| 类型名 | 说明       |
| ------ | ---------- |
| line   | 线形进度条 |
| circle | 环形进度条 |

</rewritten_file>
