import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toReadableDate() {
    return DateFormat('MMMM d, y').format(this);
  }

  String toReadableDateTime() {
    return DateFormat('MMMM d, y - h:mm a').format(this);
  }
}
