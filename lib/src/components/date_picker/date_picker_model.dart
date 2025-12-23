enum EDatePickerViewMode {
  day,
  month,
  year,
}

class EDatePickerValue {
  final DateTime? start;
  final DateTime? end;
  final List<DateTime>? multi;

  EDatePickerValue({this.start, this.end, this.multi});

  bool get isSingle => start != null && end == null && multi == null;
  bool get isRange => start != null && end != null;
  bool get isMulti => multi != null;

  @override
  String toString() {
    if (isRange) return 'Range(${start.toString()} - ${end.toString()})';
    if (isMulti) return 'Multi(${multi.toString()})';
    return 'Single(${start.toString()})';
  }
}

class EShortcut {
  final String label;
  final Duration? duration;
  final DateTime? Function()? getValue;

  EShortcut({required this.label, this.duration, this.getValue});
}
