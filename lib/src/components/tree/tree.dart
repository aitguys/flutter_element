import 'package:flutter/material.dart';

/// A tree component that displays hierarchical data in a tree structure.
/// It supports features like checkboxes, node expansion, and drag-and-drop.
class FlTreeNode {
  /// The label text to display for this node.
  final String label;

  /// The value associated with this node.
  final dynamic value;

  /// The child nodes of this node.
  final List<FlTreeNode>? children;

  /// Whether this node is disabled.
  final bool disabled;

  /// Whether this node is a leaf node.
  final bool isLeaf;

  /// A custom icon widget to display before the node label.
  final Widget? icon;

  const FlTreeNode({
    required this.label,
    this.value,
    this.children,
    this.disabled = false,
    this.isLeaf = false,
    this.icon,
  });
}

/// A tree widget that displays hierarchical data in a tree structure.
/// It follows Element Plus design guidelines.
class FlTree extends StatefulWidget {
  /// The data to display in the tree structure.
  final List<FlTreeNode> data;

  /// Whether to show checkboxes for node selection.
  final bool showCheckbox;

  /// Whether to expand all nodes by default.
  final bool defaultExpandAll;

  /// The keys of nodes that should be checked by default.
  final List<dynamic>? defaultCheckedKeys;

  /// The keys of nodes that should be expanded by default.
  final List<dynamic>? defaultExpandedKeys;

  /// Whether to enable strict checking mode.
  final bool checkStrictly;

  /// Callback function when the checked state of nodes changes.
  final Function(List<dynamic>)? onCheck;

  /// Callback function when a node is clicked.
  final Function(dynamic, bool)? onNodeClick;

  /// Whether to enable drag and drop functionality.

  /// Callback function when a node is dropped onto another node.

  const FlTree({
    super.key,
    required this.data,
    this.showCheckbox = false,
    this.defaultExpandAll = false,
    this.defaultCheckedKeys,
    this.defaultExpandedKeys,
    this.checkStrictly = false,
    this.onCheck,
    this.onNodeClick,
  });

  @override
  State<FlTree> createState() => _FlTreeState();
}

class _FlTreeState extends State<FlTree> {
  Set<dynamic> _expandedKeys = {};
  Set<dynamic> _checkedKeys = {};
  final Set<dynamic> _halfCheckedKeys = {};
  dynamic _selectedKey;

  @override
  void initState() {
    super.initState();
    if (widget.defaultExpandAll) {
      _expandAllNodes(widget.data);
    } else if (widget.defaultExpandedKeys != null) {
      _expandedKeys = Set.from(widget.defaultExpandedKeys!);
    }

    if (widget.defaultCheckedKeys != null) {
      _checkedKeys = Set.from(widget.defaultCheckedKeys!);
      if (!widget.checkStrictly) {
        _updateParentCheckState(widget.data);
      }
    }
  }

  void _expandAllNodes(List<FlTreeNode> nodes) {
    for (var node in nodes) {
      if (node.children != null && node.children!.isNotEmpty) {
        _expandedKeys.add(node.value);
        _expandAllNodes(node.children!);
      }
    }
  }

  void _updateParentCheckState(List<FlTreeNode> nodes,
      {Set<dynamic>? parentKeys}) {
    for (var node in nodes) {
      if (node.children != null && node.children!.isNotEmpty) {
        bool allChecked =
            node.children!.every((child) => _checkedKeys.contains(child.value));
        bool hasChecked = node.children!.any((child) =>
            _checkedKeys.contains(child.value) ||
            _halfCheckedKeys.contains(child.value));

        if (allChecked) {
          _checkedKeys.add(node.value);
          _halfCheckedKeys.remove(node.value);
        } else if (hasChecked) {
          _checkedKeys.remove(node.value);
          _halfCheckedKeys.add(node.value);
        } else {
          _checkedKeys.remove(node.value);
          _halfCheckedKeys.remove(node.value);
        }

        _updateParentCheckState(node.children!, parentKeys: {node.value});
      }
    }
  }

  void _toggleExpand(dynamic nodeValue) {
    setState(() {
      if (_expandedKeys.contains(nodeValue)) {
        _expandedKeys.remove(nodeValue);
      } else {
        _expandedKeys.add(nodeValue);
      }
    });
  }

  void _toggleCheck(FlTreeNode node, bool checked) {
    setState(() {
      if (checked) {
        _checkedKeys.add(node.value);
      } else {
        _checkedKeys.remove(node.value);
      }

      if (!widget.checkStrictly) {
        if (node.children != null) {
          _checkChildren(node.children!, checked);
        }
        _updateParentCheckState(widget.data);
      }

      if (widget.onCheck != null) {
        widget.onCheck!(_checkedKeys.toList());
      }
    });
  }

  void _checkChildren(List<FlTreeNode> children, bool checked) {
    for (var child in children) {
      if (checked) {
        _checkedKeys.add(child.value);
      } else {
        _checkedKeys.remove(child.value);
      }

      if (child.children != null) {
        _checkChildren(child.children!, checked);
      }
    }
  }

  Widget _buildNode(FlTreeNode node, int level) {
    bool isExpanded = _expandedKeys.contains(node.value);
    bool isChecked = _checkedKeys.contains(node.value);
    bool isHalfChecked = _halfCheckedKeys.contains(node.value);
    bool hasChildren = node.children != null && node.children!.isNotEmpty;
    bool isSelected = _selectedKey == node.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Draggable<FlTreeNode>(
          data: node,
          dragAnchorStrategy: pointerDragAnchorStrategy,
          feedback: Material(
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: Text(node.label),
            ),
          ),
          child: DragTarget<FlTreeNode>(
            onAcceptWithDetails: (data) {},
            builder: (context, candidateData, rejectedData) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedKey = node.value;
                  });
                  if (widget.onNodeClick != null) {
                    widget.onNodeClick!(node.value, !isExpanded);
                  }
                  if (hasChildren) {
                    _toggleExpand(node.value);
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(
                    left: (level * 24).toDouble(),
                    right: 8,
                    top: 8,
                    bottom: 8,
                  ),
                  color: isSelected ? Colors.blue.withOpacity(0.1) : null,
                  child: Row(
                    children: [
                      if (widget.showCheckbox)
                        Checkbox(
                          value: isChecked,
                          tristate: !widget.checkStrictly,
                          onChanged: node.disabled
                              ? null
                              : (checked) =>
                                  _toggleCheck(node, checked ?? false),
                          isError: isHalfChecked,
                        ),
                      if (hasChildren)
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          size: 18,
                        )
                      else
                        const SizedBox(width: 18),
                      if (node.icon != null) ...[
                        node.icon!,
                        const SizedBox(width: 4),
                      ],
                      Expanded(
                        child: Text(
                          node.label,
                          style: TextStyle(
                            color: node.disabled ? Colors.grey : null,
                            fontWeight: isSelected ? FontWeight.bold : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (hasChildren && isExpanded)
          Column(
            children: node.children!
                .map((child) => _buildNode(child, level + 1))
                .toList(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.data.map((node) => _buildNode(node, 0)).toList(),
      ),
    );
  }
}
