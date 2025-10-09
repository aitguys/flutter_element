import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

enum ETabType {
  card,
  border,
  segment,
}

enum ETabPosition {
  top,
  right,
  bottom,
  left,
}

class ETabs extends StatefulWidget {
  final List<ETabPane> tabs;
  final int initialActive;
  final ETabType type;
  final ETabPosition position;
  final bool closable;
  final ValueChanged<int>? onChange;
  final double? tabWidth;
  final bool stretch;
  final EColorType colorType;
  final Color? customColor;
  final Color? contentColor;

  const ETabs(
      {super.key,
      required this.tabs,
      this.initialActive = 0,
      this.type = ETabType.card,
      this.position = ETabPosition.top,
      this.closable = false,
      this.onChange,
      this.tabWidth,
      this.stretch = false,
      this.colorType = EColorType.primary,
      this.customColor,
      this.contentColor});

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
    final isVertical = widget.position == ETabPosition.left ||
        widget.position == ETabPosition.right;

    Widget tabBar = TabBar(
      controller: _controller,
      isScrollable: !widget.stretch,
      padding: const EdgeInsets.all(0),
      indicatorWeight: 0,
      labelColor: calculateContentColor(
        widget.contentColor ?? getColorByType(type: widget.colorType),
      ),
      unselectedLabelColor: getColorByType(
          type: widget.colorType, customColor: widget.customColor),
      indicator: _buildIndicator(theme),
      indicatorColor: getColorByType(
          type: widget.colorType, customColor: widget.customColor),
      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      tabs: widget.tabs.map((tab) => _buildTab(tab, theme)).toList(),
    );

    Widget tabBarView = TabBarView(
      controller: _controller,
      children: widget.tabs.map((tab) => tab.content).toList(),
    );

    if (isVertical) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: widget.position == ETabPosition.left
            ? TextDirection.ltr
            : TextDirection.rtl,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: widget.position == ETabPosition.top
          ? TextDirection.ltr
          : TextDirection.rtl,
      children: [
        _wrapTabBar(tabBar),
        Expanded(child: tabBarView),
      ],
    );
  }

  Widget _wrapTabBar(Widget tabBar) {
    if (widget.type == ETabType.segment) {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            color: getColorByType(
                type: widget.colorType, customColor: widget.customColor),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: tabBar,
        ),
      );
    }
    return tabBar;
  }

  Widget _buildTab(ETabPane tab, ThemeData theme) {
    final tabContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (tab.icon != null) ...[
          Icon(tab.icon, size: 16),
          const SizedBox(width: 8),
        ],
        Text(tab.label),
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

    switch (widget.type) {
      case ETabType.card:
        return Tab(
          height: 40,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(4)),
              border: _currentIndex == widget.tabs.indexOf(tab)
                  ? Border.all(color: theme.dividerColor)
                  : null,
            ),
            child: tabContent,
          ),
        );
      case ETabType.border:
        return Tab(
          height: 40,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: tabContent,
          ),
        );
      case ETabType.segment:
        return Tab(
          height: 32,
          child: Container(
            padding: const EdgeInsets.all(0),
            child: tabContent,
          ),
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
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(6),
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
