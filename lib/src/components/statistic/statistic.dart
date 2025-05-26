import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlStatistic extends StatelessWidget {
  final String title;
  final dynamic value;
  final String? prefix;
  final String? suffix;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final TextStyle? prefixStyle;
  final TextStyle? suffixStyle;
  final int precision;
  final String groupSeparator;
  final String decimalSeparator;
  final bool animation;
  final Duration animationDuration;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? valueColor;

  const FlStatistic({
    super.key,
    required this.title,
    required this.value,
    this.prefix,
    this.suffix,
    this.titleStyle,
    this.valueStyle,
    this.prefixStyle,
    this.suffixStyle,
    this.precision = 0,
    this.groupSeparator = ',',
    this.decimalSeparator = '.',
    this.animation = false,
    this.animationDuration = const Duration(milliseconds: 2000),
    this.prefixIcon,
    this.suffixIcon,
    this.valueColor,
  });

  String _formatNumber(dynamic value) {
    if (value == null) return '0';

    if (value is DateTime) {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(value);
    }

    if (value is String) {
      return value;
    }

    final number = value is num ? value.toDouble() : 0.0;
    final formatter = NumberFormat.decimalPattern()
      ..minimumFractionDigits = precision
      ..maximumFractionDigits = precision;

    return formatter
        .format(number)
        .replaceAll(',', groupSeparator)
        .replaceAll('.', decimalSeparator);
  }

  Widget _buildValue(BuildContext context, String formattedValue) {
    final defaultValueStyle = Theme.of(context).textTheme.headlineMedium!;
    final finalValueStyle = valueStyle?.copyWith(
          color: valueColor,
        ) ??
        defaultValueStyle.copyWith(
          color: valueColor,
        );

    if (animation && value is num) {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: (value as num).toDouble(),
        ),
        duration: animationDuration,
        builder: (context, value, child) {
          return Text(
            _formatNumber(value),
            style: finalValueStyle,
          );
        },
      );
    }

    return Text(
      formattedValue,
      style: finalValueStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedValue = _formatNumber(value);
    final defaultTitleStyle = Theme.of(context).textTheme.titleMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ?? defaultTitleStyle,
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              const SizedBox(width: 4),
            ],
            if (prefix != null) ...[
              Text(
                prefix!,
                style: prefixStyle ?? valueStyle,
              ),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: _buildValue(context, formattedValue),
            ),
            if (suffix != null) ...[
              const SizedBox(width: 4),
              Text(
                suffix!,
                style: suffixStyle ?? valueStyle,
              ),
            ],
            if (suffixIcon != null) ...[
              const SizedBox(width: 4),
              suffixIcon!,
            ],
          ],
        ),
      ],
    );
  }
}

class FlCountdown extends StatefulWidget {
  final String title;
  final DateTime value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final VoidCallback? onFinish;
  final String format;

  const FlCountdown({
    super.key,
    required this.title,
    required this.value,
    this.titleStyle,
    this.valueStyle,
    this.onFinish,
    this.format = 'HH:mm:ss',
  });

  @override
  State<FlCountdown> createState() => _FlCountdownState();
}

class _FlCountdownState extends State<FlCountdown> {
  late DateTime _endTime;
  Duration _timeLeft = Duration.zero;

  @override
  void initState() {
    super.initState();
    _endTime = widget.value;
    _updateTime();
    _startTimer();
  }

  void _updateTime() {
    final now = DateTime.now();
    if (_endTime.isAfter(now)) {
      setState(() {
        _timeLeft = _endTime.difference(now);
      });
    } else {
      _timeLeft = Duration.zero;
      widget.onFinish?.call();
    }
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _updateTime();
        if (_timeLeft > Duration.zero) {
          _startTimer();
        }
      }
    });
  }

  String _formatTime() {
    final hours = _timeLeft.inHours;
    final minutes = _timeLeft.inMinutes.remainder(60);
    final seconds = _timeLeft.inSeconds.remainder(60);

    String format = widget.format;
    format = format.replaceAll('HH', hours.toString().padLeft(2, '0'));
    format = format.replaceAll('mm', minutes.toString().padLeft(2, '0'));
    format = format.replaceAll('ss', seconds.toString().padLeft(2, '0'));

    return format;
  }

  @override
  Widget build(BuildContext context) {
    return FlStatistic(
      title: widget.title,
      value: _formatTime(),
      titleStyle: widget.titleStyle,
      valueStyle: widget.valueStyle,
    );
  }
}
