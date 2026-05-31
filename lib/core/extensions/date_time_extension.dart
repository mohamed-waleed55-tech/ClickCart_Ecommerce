import 'package:intl/intl.dart';
extension DateTimeExtension on DateTime{
  String formattedTime() {
    return DateFormat('MMM dd, yyyy').format(this);
  }
}

