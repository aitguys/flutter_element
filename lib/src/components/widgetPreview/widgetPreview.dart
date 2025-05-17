import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:http/http.dart' as http;

class WidgetPreview extends StatefulWidget {
  final Widget widget;
  final String code;
  final String? title;

  const WidgetPreview({
    super.key,
    required this.widget,
    required this.code,
    this.title,
  });

  @override
  State<WidgetPreview> createState() => _WidgetPreviewState();
}

class _WidgetPreviewState extends State<WidgetPreview> {
  bool _expanded = false;
  String? _code;
  bool _isLoading = false;

  Future<void> _loadCode() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.code.startsWith('http')) {
        final response = await http.get(Uri.parse(widget.code));
        if (response.statusCode == 200) {
          setState(() {
            _code = response.body;
          });
        } else {
          setState(() {
            _code = '加载代码失败: ${response.statusCode}';
          });
        }
      } else {
        setState(() {
          _code = widget.code;
        });
      }
    } catch (e) {
      setState(() {
        _code = '加载代码失败: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _copyCode() {
    if (_code != null) {
      Clipboard.setData(ClipboardData(text: _code!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('代码已复制到剪贴板')),
      );
    }
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded && _code == null) {
        _loadCode();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      shadowColor: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.title != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  bottom: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: Text(
                widget.title!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(child: widget.widget),
          ),
          const Divider(height: 1),
          Material(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
            child: InkWell(
              onTap: _toggleExpanded,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(
                      _expanded ? Icons.code_off : Icons.code,
                      size: 18,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '查看代码',
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const Spacer(),
                    if (_expanded && !_isLoading)
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        onPressed: _copyCode,
                        color: theme.colorScheme.primary,
                        tooltip: '复制代码',
                      ),
                    Icon(
                      _expanded ? Icons.expand_less : Icons.expand_more,
                      size: 18,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        child: SyntaxView(
                            code: _code ?? '', // Code text
                            syntax: Syntax.DART, // Language
                            syntaxTheme: SyntaxTheme.vscodeLight(), // Theme
                            fontSize: 14.0, // Font size
                            withZoom: true, // Enable/Disable zoom icon controls
                            withLinesCount: true, // Enable/Disable line number
                            expanded:
                                true, // Enable/Disable container expansion
                            selectable:
                                true // Enable/Disable code text selection
                            ),
                      ),
                    ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
