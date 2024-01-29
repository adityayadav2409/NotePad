import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  String fullDate() {
    return DateFormat.yMMMd('en_US')
        .format(DateTime.fromMicrosecondsSinceEpoch((microsecondsSinceEpoch)));
  }
}
