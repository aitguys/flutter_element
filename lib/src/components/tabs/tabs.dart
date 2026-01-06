import 'package:flutter/material.dart';
import 'package:flutter_element_plus/src/theme/index.dart';

enum ETabType {
  card,
  border, // 对应 Line/Underline
  segment, // 对应 Button/Capsule
}

enum ETabPosition {
  top,
  bottom,
  left,
  right,
}

class ETabs extends StatefulWidget {
  final List<ETabPane> tabs;
  final int initialActive;
  final ETabType type;
  final ETabPosition position;
  final bool closable;
  final ValueChanged<int>? onChange;
  final double? tabWidth; // 仅在 vertical 模式下生效或 stretch=false 时生效
  final bool stretch; // 是否拉伸填满
  final EColorType colorType;
  final Color? customColor;
  final double height; // 整体高度，默认为空自适应

  /// 自定义 TabBar 的背景色
  final Color? tabBarBackgroundColor;

  const ETabs({
    super.key,
    required this.tabs,
    this.initialActive = 0,
    this.type = ETabType.border, // 默认改为 border (line)
    this.position = ETabPosition.top, // 默认 top
    this.closable = false,
    this.onChange,
    this.tabWidth,
    this.stretch = false,
    this.colorType = EColorType.primary,
    this.customColor,
    this.height = 300, // 给个默认高度，避免报错，但在 Column 中通常需要 Expanded
    this.tabBarBackgroundColor,
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
  void didUpdateWidget(ETabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabs.length != widget.tabs.length) {
      _controller.removeListener(_handleTabSelection);
      _controller.dispose();
      _controller = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: (_currentIndex >= widget.tabs.length) ? 0 : _currentIndex,
      );
      _controller.addListener(_handleTabSelection);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabSelection);
    _controller.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_controller.indexIsChanging) {
      // TabBar 点击触发
      setState(() {
        _currentIndex = _controller.index;
      });
      widget.onChange?.call(_controller.index);
    } else if (_controller.animation != null) {
      // 滑动结束触发
      final int newIndex = _controller.index;
      if (_currentIndex != newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
        widget.onChange?.call(newIndex);
      }
    }
  }

  Color get _primaryColor =>
      getColorByType(type: widget.colorType, customColor: widget.customColor);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 构建 TabBar
    Widget tabBar = _buildTabBar(theme);

    // 构建 Content
    Widget content = TabBarView(
      controller: _controller,
      physics: const BouncingScrollPhysics(), // 增加回弹效果，符合手机习惯
      children: widget.tabs.map((tab) => tab.content).toList(),
    );

    // 根据 Position 组合
    switch (widget.position) {
      case ETabPosition.top:
        return Column(
          children: [
            tabBar,
            if (widget.type != ETabType.segment && widget.type != ETabType.card)
              const Divider(height: 1, thickness: 0.5), // segment 和 card 不显示分割线
            Expanded(child: content),
          ],
        );
      case ETabPosition.bottom:
        return Column(
          children: [
            Expanded(child: content),
            if (widget.type != ETabType.segment && widget.type != ETabType.card)
              const Divider(height: 1, thickness: 0.5),
            tabBar,
          ],
        );
      case ETabPosition.left:
        return Row(
          children: [
            _buildVerticalTabBarWrapper(tabBar),
            if (widget.type != ETabType.segment && widget.type != ETabType.card)
              const VerticalDivider(width: 1, thickness: 0.5),
            Expanded(child: content),
          ],
        );
      case ETabPosition.right:
        return Row(
          children: [
            Expanded(child: content),
            if (widget.type != ETabType.segment && widget.type != ETabType.card)
              const VerticalDivider(width: 1, thickness: 0.5),
            _buildVerticalTabBarWrapper(tabBar),
          ],
        );
    }
  }

  Widget _buildVerticalTabBarWrapper(Widget tabBar) {
    // 垂直 TabBar 实现
    // 使用 RotatedBox 旋转 TabBar，注意此时 TabBar 是横向渲染的，旋转后变成垂直
    // 文字也需要反向旋转
    return SizedBox(
      width: widget.tabWidth ?? 100,
      child: RotatedBox(
        quarterTurns: 1,
        child: tabBar,
      ),
    );
  }

  Widget _buildTabBar(ThemeData theme) {
    bool isVertical = widget.position == ETabPosition.left ||
        widget.position == ETabPosition.right;
    bool isSegment = widget.type == ETabType.segment;

    // 如果是垂直模式，Tab 内容需要反向旋转
    // 如果是水平模式，Tab 内容正常

    Widget tabBar = TabBar(
      controller: _controller,
      isScrollable:
          isVertical ? true : !widget.stretch, // 垂直模式必须 scrollable 否则溢出
      tabAlignment: isVertical || !widget.stretch
          ? TabAlignment.start
          : TabAlignment.fill,
      labelColor: isSegment ? _primaryColor : _primaryColor, // Segment 选中颜色调整
      unselectedLabelColor: EBasicColors.textGray,
      indicator: _buildIndicator(theme),
      indicatorSize: TabBarIndicatorSize.tab, // Segment 必须是 tab 才能填满
      dividerColor: Colors.transparent, // 移除默认分割线
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      unselectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      padding: isVertical
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 4),
      labelPadding: isVertical
          ? const EdgeInsets.symmetric(
              horizontal: 20, vertical: 0) // 旋转后的 padding
          : const EdgeInsets.symmetric(horizontal: 16),
      tabs: widget.tabs.asMap().entries.map((entry) {
        final index = entry.key;
        final tab = entry.value;
        final isSelected = _currentIndex == index;

        Widget child = _buildTabItem(tab, isSelected, isVertical);

        if (isVertical) {
          // 垂直模式下，TabBar 旋转了 90 度，TabItem 需要逆时针旋转 90 度回正
          child = RotatedBox(quarterTurns: -1, child: child);
        }

        return Tab(
          height: isVertical
              ? (widget.tabWidth ?? 100)
              : (isSegment ? 32 : 40), // 调整 Segment 高度
          child: child,
        );
      }).toList(),
    );

    // Segment 风格增加背景容器
    if (isSegment) {
      return Container(
        height: isVertical ? null : 40, // 增加容器高度，给 padding 留空间
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F5), // 浅灰背景
          borderRadius: BorderRadius.circular(6),
        ),
        child: tabBar,
      );
    }

    return Container(
      color: widget.tabBarBackgroundColor ?? theme.scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  Widget _buildTabItem(ETabPane tab, bool isSelected, bool isVertical) {
    Color textColor;
    if (widget.type == ETabType.segment) {
      // Segment 模式选中也是主色(或黑色)，未选中是灰色
      // 背景色改为白色
      textColor = isSelected ? Colors.black87 : EBasicColors.textGray;
    } else {
      textColor = isSelected ? _primaryColor : EBasicColors.textGray;
    }

    Widget content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (tab.icon != null) ...[
          Icon(tab.icon, size: 16, color: textColor),
          const SizedBox(width: 4), // 间距减小
        ],
        Text(
          tab.label,
          style: TextStyle(color: textColor),
        ),
        if (widget.closable && tab.closable != false) ...[
          const SizedBox(width: 4),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: Icon(Icons.close,
                size: 14, color: textColor.withValues(alpha: 0.6)),
          ),
        ],
      ],
    );

    // Card 模式包裹
    if (widget.type == ETabType.card) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? EBasicColors.borderGray : Colors.transparent,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          color: isSelected ? Colors.white : const Color(0xFFF5F7FA),
        ),
        child: content,
      );
    }

    return content;
  }

  Decoration _buildIndicator(ThemeData theme) {
    switch (widget.type) {
      case ETabType.card:
        return const BoxDecoration(); // Card 模式没有 Indicator，靠背景色
      case ETabType.border:
        return UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: _primaryColor),
          insets: const EdgeInsets.only(bottom: 4), // 调整下划线位置
        );
      case ETabType.segment:
        return BoxDecoration(
          color: Colors.white, // 选中背景为白色
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
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
