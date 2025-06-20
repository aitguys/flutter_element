#  主题

所有组件的样式控制基本都依赖两个类 `EColorType` 和 `ESizeItem` ， 这两个类定义了组件的样式。

## EColorType

`EColorType` 定义了组件的样式类型， 包括 `primary`、`success`、`warning`、`danger`、`info`、`default_` , default 是dart 语言的保留字， 所以使用 default_ 代替。
| 类型 | 说明 | 颜色 |
| --- | --- | --- |
| primary | 主要颜色 | <div style="background-color: #409EFF; color: white; padding: 2px 8px; border-radius: 4px;">#409EFF</div> |
| success | 成功颜色 | <div style="background-color: #67C23A; color: white; padding: 2px 8px; border-radius: 4px;">#67C23A</div> |
| warning | 警告颜色 | <div style="background-color: #E6A23C; color: white; padding: 2px 8px; border-radius: 4px;">#E6A23C</div> |
| danger | 危险颜色 | <div style="background-color: #F56C6C; color: white; padding: 2px 8px; border-radius: 4px;">#F56C6C</div> |
| info | 信息颜色 | <div style="background-color: #909399; color: white; padding: 2px 8px; border-radius: 4px;">#909399</div> |
| default_ | 默认颜色 | <div style="background-color: #F5F7FA; color: #303133; padding: 2px 8px; border-radius: 4px;">#F5F7FA</div> |

文字颜色、背景颜色、图标颜色等都是根据 `EColorType` 的类型来自动计算的，
提供`EColorType` 参数的组件都同时支持 `customColor` 参数， 这个参数可以传入一个颜色， 这个颜色会覆盖 `EColorType` 的类型计算出的颜色,优先级会比 `EColorType` 的类型计算出的颜色高。

## ESizeItem

`ESizeItem` 定义了组件的尺寸， 包括 `small`、`medium`、`large` 等。