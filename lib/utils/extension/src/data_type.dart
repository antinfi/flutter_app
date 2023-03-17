import 'package:intl/intl.dart';

extension ObjectExt on Object? {
  /// find object is null or empty for string, list, map, set, iterable
  bool get isNullOrEmpty {
    if (this == null) return true;
    if (this is String) return (this as String?)!.trim().isEmpty;
    if (this is Iterable) return (this as Iterable?)!.isEmpty;
    if (this is Map) return (this as Map?)!.isEmpty;
    return false;
  }
}

extension ListExt<T> on List<T> {
  /// first element or null without throwing error
  T? get firstOrNull => isEmpty ? null : first;

  /// find element or null in the list that satisfies the provided [test]
  T? find(bool Function(T element) test) {
    if (!isNullOrEmpty) {
      final index = indexWhere(test);
      return -1 < index ? this[index] : null;
    }
    return null;
  }
}

extension DateTimeExt on DateTime {
  DateTime date() => DateTime(year, month, day);

  DateTime addDays(int days) => add(Duration(days: days));

  DateTime subtractDays(int days) => subtract(Duration(days: days));

  bool isSameDate(DateTime other) => other.date() == date();

  bool isToday() => DateTime.now().date() == date();

  String toChatHeaderDate(DateFormat dateFormat) {
    final today = DateTime.now().date();
    if (today == date()) return 'Today';
    if (today.subtract(const Duration(days: 1)) == date()) return 'Yesterday';
    return dateFormat.format(this);
  }

  String toFormat(String format, {String locale = 'en_US'}) => DateFormat(format, locale).format(this);

  String toDefaultFormat() => DateFormat('dd MMM yyyy', 'en').format(this);
}

extension CurrencyExt on num? {
  String get toCurrency {
    final number = num.parse(this?.toStringAsFixed(2) ?? '0');
    return NumberFormat.currency(symbol: '₹', decimalDigits: number == number.toInt() ? 0 : 2, locale: 'en_IN').format(this);
  }

  String get toCompactCurrency {
    final number = num.parse(this?.toStringAsFixed(2) ?? '0');
    return NumberFormat.compactCurrency(symbol: '₹', decimalDigits: number == number.toInt() ? 0 : 2, locale: 'en_IN').format(this);
  }

  String get addLeadingZero => NumberFormat('00').format(this);

  String get toRoundInt {
    if (this == null) return '0';
    final number = num.parse(this?.toStringAsFixed(2) ?? '0');
    return number.toStringAsFixed(number == number.toInt() ? 0 : 2);
  }
}

extension StringExt on String {
  String lastSegment([Pattern? pattern]) {
    final results = split(pattern ?? '/');
    return results.isEmpty ? '' : results.last;
  }

  String get fileExtension {
    final result = split('.');
    return result.isNotEmpty ? result.last : '';
  }
}
