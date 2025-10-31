import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

/// 步骤条的方向：横向或纵向
enum EStepDirection {
  horizontal,
  vertical,
}

/// 步骤条每个分步的数据模型
class EStep {
  final String title;
  final String? description;
  final IconData? icon;
  final EColorType colorType;
  final Widget? customIcon;

  const EStep({
    required this.title,
    this.description,
    this.icon,
    this.colorType = EColorType.primary,
    this.customIcon,
  });
}

/// ESteps 组件：参考 Element Plus，增加了属性和布局兼容
class ESteps extends StatelessWidget {
  /// 步骤列表
  final List<EStep> steps;

  /// 当前激活步骤的索引
  final int active;

  /// 步骤条方向
  final EStepDirection direction;

  /// 步骤条是否居中
  final bool alignCenter;

  /// 步骤条激活时的颜色类型
  final EColorType processColorType;

  /// 步骤条完成时的颜色类型
  final EColorType finishColorType;

  /// 步骤间距，horizontal时为每一步宽度百分比，vertical时为每步高度
  final double? space;

  /// 完成状态自定义节点
  final Widget? finishWidget;

  const ESteps({
    Key? key,
    required this.steps,
    this.active = 0,
    this.direction = EStepDirection.horizontal,
    this.alignCenter = false,
    this.processColorType = EColorType.primary,
    this.finishColorType = EColorType.success,
    this.space,
    this.finishWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return direction == EStepDirection.horizontal
        ? _buildHorizontal(context)
        : _buildVertical(context);
  }

  Widget _buildHorizontal(BuildContext context) {
    final int count = steps.length;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          alignCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: List.generate(count, (i) {
        final bool isActive = i == active;
        final bool isFinished = i < active;
        final bool isLast = i == count - 1;

        return Expanded(
          flex: space != null ? 0 : 1,
          child: Container(
            padding: space != null
                ? EdgeInsets.symmetric(horizontal: space! / 2)
                : EdgeInsets.zero,
            child: _StepItem(
              step: steps[i],
              index: i,
              isActive: isActive,
              isFinished: isFinished,
              isLast: isLast,
              processColorType: processColorType,
              finishColorType: finishColorType,
              finishWidget: finishWidget,
              direction: direction,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildVertical(BuildContext context) {
    final int count = steps.length;
    return Column(
      crossAxisAlignment:
          alignCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: List.generate(count, (i) {
        final bool isActive = i == active;
        final bool isFinished = i < active;
        final bool isLast = i == count - 1;

        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: isLast ? 0 : (space ?? 12.0)),
          child: _StepItem(
            step: steps[i],
            index: i,
            isActive: isActive,
            isFinished: isFinished,
            isLast: isLast,
            processColorType: processColorType,
            finishColorType: finishColorType,
            finishWidget: finishWidget,
            direction: direction,
          ),
        );
      }),
    );
  }
}

/// 单个步骤的实现
class _StepItem extends StatelessWidget {
  final EStep step;
  final int index;
  final bool isActive;
  final bool isFinished;
  final bool isLast;
  final EColorType processColorType;
  final EColorType finishColorType;
  final Widget? finishWidget;
  final EStepDirection direction;

  const _StepItem({
    required this.step,
    required this.index,
    required this.isActive,
    required this.isFinished,
    required this.isLast,
    required this.processColorType,
    required this.finishColorType,
    required this.finishWidget,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    Widget iconWidget;
    if (isFinished) {
      iconWidget = Container(
        decoration: BoxDecoration(
          color: getColorByType(type: finishColorType),
          shape: BoxShape.circle,
        ),
        width: 30,
        height: 30,
        child: finishWidget ??
            const Icon(Icons.check, size: 20.0, color: Colors.white),
      );
    } else if (step.customIcon != null) {
      iconWidget = step.customIcon!;
    } else if (step.icon != null) {
      iconWidget = Container(
        decoration: BoxDecoration(
          color: getColorByType(type: step.colorType),
          shape: BoxShape.circle,
        ),
        width: 35,
        height: 35,
        child: Icon(step.icon, color: Colors.white, size: 20.0),
      );
    } else {
      iconWidget = CircleAvatar(
        radius: 15,
        backgroundColor: isActive
            ? getColorByType(type: processColorType)
            : getColorByType(type: step.colorType).withValues(alpha: 0.6),
        child: Text(
          '${index + 1}',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      );
    }

    // 连接线条
    Widget connector = SizedBox.shrink();
    if (!isLast) {
      connector = direction == EStepDirection.horizontal
          ? Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.only(top: 16),
                color: isFinished
                    ? getColorByType(type: finishColorType)
                    : getColorByType(type: step.colorType)
                        .withValues(alpha: 0.3),
              ),
            )
          : Container(
              width: 2,
              height: 32,
              margin: const EdgeInsets.only(
                left: 0, // will align with icon below using Stack
              ),
              color: isFinished
                  ? getColorByType(type: finishColorType)
                  : getColorByType(type: step.colorType).withValues(alpha: 0.3),
            );
    }

    if (direction == EStepDirection.horizontal) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              iconWidget,
              if (step.description != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    step.description!,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ),
            ],
          ),
          if (!isLast) connector,
        ],
      );
    } else {
      //嵌套Stack以保证icon和竖线在垂直方向上对齐居中
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Connector - vertical bar starts under the icon, bottom aligned with icon bottom
                Column(
                  children: [
                    const SizedBox(
                        height:
                            30), // icon height (CircleAvatar 30x30, Container 30x30 or 35x35)
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 32,
                        color: isFinished
                            ? getColorByType(type: finishColorType)
                            : getColorByType(type: step.colorType)
                                .withValues(alpha: 0.3),
                      ),
                  ],
                ),
                // Icon, always on top
                Align(
                  alignment: Alignment.topCenter,
                  child: iconWidget,
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive
                        ? getColorByType(type: processColorType)
                        : Colors.black87,
                    fontSize: 16,
                  ),
                ),
                if (step.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      step.description!,
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
