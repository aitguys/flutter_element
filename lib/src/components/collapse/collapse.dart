import 'package:flutter/material.dart';

/// The position of the expand icon in a collapse panel.
enum ECollapsePanelPosition { left, right }

/// A collapsible panel component that follows Element Plus design guidelines.
///
/// The [ECollapse] widget provides a container that can be expanded or collapsed
/// to show or hide content. It supports multiple panels, accordion mode, and
/// custom expand icons.
class ECollapse extends StatefulWidget {
  /// The list of panels to display in the collapse component.
  final List<ECollapsePanel> panels;

  /// The indexes of the currently active panels.
  final List<int>? activeIndexes;

  /// Whether to enable accordion mode.
  final bool accordion;

  /// Callback function when the active panels change.
  final ValueChanged<List<int>>? onChange;

  /// The position of the expand icon in the panels.
  final ECollapsePanelPosition position;

  const ECollapse({
    super.key,
    required this.panels,
    this.activeIndexes,
    this.accordion = false,
    this.onChange,
    this.position = ECollapsePanelPosition.right,
  });

  @override
  State<ECollapse> createState() => _ECollapseState();
}

class _ECollapseState extends State<ECollapse> {
  late List<int> _activeIndexes;

  @override
  void initState() {
    super.initState();
    _activeIndexes = widget.activeIndexes ?? [];
  }

  void _handlePanelTap(int index, bool disabled) {
    if (disabled) return;
    setState(() {
      if (widget.accordion) {
        _activeIndexes = _activeIndexes.contains(index) ? [] : [index];
      } else {
        if (_activeIndexes.contains(index)) {
          _activeIndexes.remove(index);
        } else {
          _activeIndexes.add(index);
        }
      }
    });
    widget.onChange?.call(_activeIndexes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.panels.length, (i) {
        final panel = widget.panels[i];
        final isActive = _activeIndexes.contains(i);
        return _CollapsePanelWidget(
          title: panel.title,
          isActive: isActive,
          disabled: panel.disabled,
          onTap: () => _handlePanelTap(i, panel.disabled),
          position: widget.position,
          expandIcon: panel.expandIcon,
          child: panel.child,
        );
      }),
    );
  }
}

/// A panel in a collapse component.
class ECollapsePanel {
  /// The title widget to display in the panel header.
  final Widget title;

  /// The content widget to display when the panel is expanded.
  final Widget child;

  /// Whether the panel is disabled.
  final bool disabled;

  /// A custom icon to use for expanding/collapsing the panel.
  final Widget? expandIcon;

  ECollapsePanel({
    required this.title,
    required this.child,
    this.disabled = false,
    this.expandIcon,
  });
}

class _CollapsePanelWidget extends StatelessWidget {
  final Widget title;
  final Widget child;
  final bool isActive;
  final bool disabled;
  final VoidCallback onTap;
  final ECollapsePanelPosition position;
  final Widget? expandIcon;

  const _CollapsePanelWidget({
    required this.title,
    required this.child,
    required this.isActive,
    required this.disabled,
    required this.onTap,
    required this.position,
    this.expandIcon,
  });

  @override
  Widget build(BuildContext context) {
    final icon = expandIcon ??
        Icon(
          isActive ? Icons.expand_less : Icons.expand_more,
          color: disabled ? Colors.grey : Colors.black54,
        );

    final titleRow = Row(
      children: position == ECollapsePanelPosition.right
          ? [
              Expanded(
                  child: DefaultTextStyle(
                style: TextStyle(
                  color: disabled ? Colors.grey : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                child: title,
              )),
              const SizedBox(width: 8),
              icon,
            ]
          : [
              icon,
              const SizedBox(width: 8),
              Expanded(
                  child: DefaultTextStyle(
                style: TextStyle(
                  color: disabled ? Colors.grey : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                child: title,
              )),
            ],
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          InkWell(
            onTap: disabled ? null : onTap,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: disabled ? Colors.grey[200] : Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: titleRow,
            ),
          ),
          ClipRect(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isActive
                  ? Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: child,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
