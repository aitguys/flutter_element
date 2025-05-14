import 'package:flutter/material.dart';

enum EStepStatus {
  wait,
  process,
  finish,
  error,
}

enum EStepDirection {
  vertical,
  horizontal,
}

class ESteps extends StatelessWidget {
  final List<EStep> steps;
  final int active;
  final EStepDirection direction;
  final bool alignCenter;
  final double? space;
  final bool progressDot;
  final bool finishStatus;

  const ESteps({
    Key? key,
    required this.steps,
    this.active = 0,
    this.direction = EStepDirection.horizontal,
    this.alignCenter = false,
    this.space,
    this.progressDot = false,
    this.finishStatus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return direction == EStepDirection.horizontal
        ? Row(
            mainAxisAlignment: alignCenter
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: _buildSteps(),
          )
        : Column(
            crossAxisAlignment: alignCenter
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: _buildSteps(),
          );
  }

  List<Widget> _buildSteps() {
    final List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      final isLast = i == steps.length - 1;
      final status = _getStepStatus(i);

      if (direction == EStepDirection.horizontal) {
        items.add(
          Flexible(
            flex: 1,
            child: EStepItem(
              title: step.title,
              description: step.description,
              icon: step.icon,
              status: status,
              direction: direction,
              progressDot: progressDot,
              isLast: isLast,
              space: space,
            ),
          ),
        );
      } else {
        items.add(
          EStepItem(
            title: step.title,
            description: step.description,
            icon: step.icon,
            status: status,
            direction: direction,
            progressDot: progressDot,
            isLast: isLast,
            space: space,
          ),
        );
      }
    }
    return items;
  }

  EStepStatus _getStepStatus(int index) {
    if (index < active) {
      return finishStatus ? EStepStatus.finish : EStepStatus.process;
    } else if (index == active) {
      return EStepStatus.process;
    }
    return EStepStatus.wait;
  }
}

class EStep {
  final String title;
  final String? description;
  final IconData? icon;

  const EStep({
    required this.title,
    this.description,
    this.icon,
  });
}

class EStepItem extends StatelessWidget {
  final String title;
  final String? description;
  final IconData? icon;
  final EStepStatus status;
  final EStepDirection direction;
  final bool progressDot;
  final bool isLast;
  final double? space;

  const EStepItem({
    Key? key,
    required this.title,
    this.description,
    this.icon,
    required this.status,
    required this.direction,
    required this.progressDot,
    required this.isLast,
    this.space,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHorizontal = direction == EStepDirection.horizontal;

    return Container(
      margin: EdgeInsets.only(
        right: isHorizontal && !isLast ? (space ?? 50.0) : 0,
        bottom: !isHorizontal && !isLast ? (space ?? 20.0) : 0,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIcon(theme),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: _getTitleColor(theme),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      description!,
                      style: TextStyle(
                        color: theme.textTheme.bodySmall?.color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!isLast && isHorizontal)
              Container(
                width: 50,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Container(
                    height: 1,
                    color: _getLineColor(theme),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    final color = _getIconColor(theme);
    final size = progressDot ? 8.0 : 24.0;

    if (progressDot) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: status == EStepStatus.wait ? Colors.white : color,
        shape: BoxShape.circle,
        border: Border.all(
          color: status == EStepStatus.wait
              ? theme.dividerColor
              : Colors.transparent,
        ),
      ),
      child: Center(
        child: icon != null
            ? Icon(
                icon,
                size: 16,
                color: status == EStepStatus.wait ? color : Colors.white,
              )
            : _buildDefaultIcon(theme),
      ),
    );
  }

  Widget _buildDefaultIcon(ThemeData theme) {
    if (status == EStepStatus.finish) {
      return const Icon(
        Icons.check,
        size: 16,
        color: Colors.white,
      );
    } else if (status == EStepStatus.error) {
      return const Icon(
        Icons.close,
        size: 16,
        color: Colors.white,
      );
    }
    return Text(
      '${title[0]}',
      style: TextStyle(
        fontSize: 14,
        color: status == EStepStatus.wait ? _getIconColor(theme) : Colors.white,
      ),
    );
  }

  Color _getIconColor(ThemeData theme) {
    switch (status) {
      case EStepStatus.finish:
      case EStepStatus.process:
        return theme.primaryColor;
      case EStepStatus.error:
        return theme.colorScheme.error;
      case EStepStatus.wait:
        return theme.disabledColor;
    }
  }

  Color _getTitleColor(ThemeData theme) {
    switch (status) {
      case EStepStatus.finish:
      case EStepStatus.process:
        return theme.textTheme.bodyLarge?.color ?? Colors.black87;
      case EStepStatus.error:
        return theme.colorScheme.error;
      case EStepStatus.wait:
        return theme.textTheme.bodySmall?.color ?? Colors.black54;
    }
  }

  Color _getLineColor(ThemeData theme) {
    return status == EStepStatus.wait
        ? theme.dividerColor
        : theme.primaryColor.withOpacity(0.3);
  }
}
