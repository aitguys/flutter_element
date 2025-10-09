import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

enum ETabType {
  card,
  border,
  segment,
}

class ETabs extends StatefulWidget {
  final List<ETabPane> tabs;
  final int initialActive;
  final ETabType type;
  final bool closable;
  final ValueChanged<int>? onChange;
  final double? tabWidth;
  final bool stretch;
  final EColorType colorType;
  final Color? customColor;

  /// 新增 width 属性，默认 'auto'，也可以传入数字
  final dynamic width; // double 或 'auto'

  const ETabs({
    super.key,
    required this.tabs,
    this.initialActive = 0,
    this.type = ETabType.card,
    this.closable = false,
    this.onChange,
    this.tabWidth,
    this.stretch = false,
    this.colorType = EColorType.primary,
    this.customColor,
    this.width = 'auto', // 默认 auto
  });

  @override
  State<ETabs> createState() => _ETabsState();
}

class _ETabsState extends State<ETabs> with SingleTickerProviderStateMixin {
  late TabController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialActive;
    _controller = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: widget.initialActive,
    );
    _controller.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabSelection);
    _controller.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_controller.indexIsChanging) {
      setState(() {
        _currentIndex = _controller.index;
      });
      widget.onChange?.call(_controller.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget tabBar = TabBar(
      controller: _controller,
      isScrollable: !widget.stretch && widget.width == 'auto',
      labelColor: theme.primaryColor,
      unselectedLabelColor: theme.textTheme.bodyMedium?.color,
      indicator: _buildIndicator(theme),
      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      padding: EdgeInsets.zero,
      tabAlignment: TabAlignment.start,
      tabs: widget.tabs
          .asMap()
          .entries
          .map((entry) => _buildTab(entry.value, theme, entry.key))
          .toList(),
    );

    Widget tabBarView = TabBarView(
      controller: _controller,
      children: widget.tabs.map((tab) => tab.content).toList(),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: [
        SizedBox(
          width: widget.tabWidth ?? 200,
          child: RotatedBox(
            quarterTurns: 0,
            child: tabBar,
          ),
        ),
        Expanded(child: tabBarView),
      ],
    );
  }

  Widget _buildTab(ETabPane tab, ThemeData theme, int index) {
    final tabContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (tab.icon != null) ...[
          Icon(tab.icon, size: 16),
          const SizedBox(width: 8),
        ],
        Text(
          tab.label,
          style: TextStyle(
              color: calculateContentColor(getBackGroundColorByTypeAndTheme(
                  type: widget.colorType, customColor: widget.customColor))),
        ),
        if (widget.closable && tab.closable != false) ...[
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              // Handle close action
            },
            child: const Icon(Icons.close, size: 14),
          ),
        ],
      ],
    );

    Widget tabChild = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: tabContent,
    );

    switch (widget.type) {
      case ETabType.card:
        return Tab(
          iconMargin: EdgeInsets.zero,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(4)),
              border: _currentIndex == index
                  ? Border.all(color: theme.dividerColor)
                  : null,
            ),
            child: tabChild,
          ),
        );
      case ETabType.border:
        return Tab(
          height: 40,
          child: tabChild,
        );
      case ETabType.segment:
        return Tab(
          height: 32,
          child: tabChild,
        );
    }
  }

  Decoration _buildIndicator(ThemeData theme) {
    switch (widget.type) {
      case ETabType.card:
        return const BoxDecoration();
      case ETabType.border:
        return UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: theme.primaryColor),
        );
      case ETabType.segment:
        return BoxDecoration(
          color: getColorByType(
              type: widget.colorType, customColor: widget.customColor),
          borderRadius: BorderRadius.circular(2),
        );
    }
  }
}

class ETabPane {
  final String label;
  final Widget content;
  final IconData? icon;
  final bool? closable;
  final bool? disabled;

  const ETabPane({
    required this.label,
    required this.content,
    this.icon,
    this.closable,
    this.disabled,
  });
}
