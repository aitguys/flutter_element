import 'package:flutter/material.dart';

class ECollapse extends StatefulWidget {
  final List<ECollapsePanel> panels;
  final List<int>? activeIndexes;
  final bool accordion;
  final ValueChanged<List<int>>? onChange;

  const ECollapse({
    Key? key,
    required this.panels,
    this.activeIndexes,
    this.accordion = false,
    this.onChange,
  }) : super(key: key);

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
          child: panel.child,
          isActive: isActive,
          disabled: panel.disabled,
          onTap: () => _handlePanelTap(i, panel.disabled),
        );
      }),
    );
  }
}

class ECollapsePanel {
  final Widget title;
  final Widget child;
  final bool disabled;

  ECollapsePanel({
    required this.title,
    required this.child,
    this.disabled = false,
  });
}

class _CollapsePanelWidget extends StatelessWidget {
  final Widget title;
  final Widget child;
  final bool isActive;
  final bool disabled;
  final VoidCallback onTap;

  const _CollapsePanelWidget({
    required this.title,
    required this.child,
    required this.isActive,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Row(
                children: [
                  Icon(
                    isActive ? Icons.expand_less : Icons.expand_more,
                    color: disabled ? Colors.grey : Colors.black54,
                  ),
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
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: child,
            ),
            crossFadeState:
                isActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
