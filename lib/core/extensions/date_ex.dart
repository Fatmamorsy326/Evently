import 'package:intl/intl.dart';

extension DateEx on DateTime{
  String get monthName{
    DateFormat date=DateFormat("MMM");
    return date.format(this);
  }
  String get formattedDate{
    return DateFormat("yMMMMd").format(this);
}
String get formattedTime{
    return DateFormat.jm().format(this);
}
}