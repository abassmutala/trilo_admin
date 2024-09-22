import 'package:intl/intl.dart';

class DateTimeFormats {
  static DateFormat day = DateFormat('d');//10
  static DateFormat dateFormat = DateFormat('EEE, MMM d'); //Wed, Feb 10
  static DateFormat dayMonth = DateFormat('d MMM'); //10 Feb
  static DateFormat weekday = DateFormat('EEE'); //Wed
  static DateFormat fullMonth = DateFormat('MMMMM');
  static DateFormat fullYear = DateFormat('yyyy');
  static DateFormat longDate = DateFormat('EEE, MMM d y');
  static DateFormat monthYear = DateFormat('MMM y');
  static DateFormat fullDate = DateFormat('d LLLL y');
  static DateFormat dateTime = DateFormat('EEE, MMM d y; HH:mm:ss');
  static DateFormat shortDateTime = DateFormat('EEE, MMM d; HH:mm');
  static DateFormat hourMinute = DateFormat('Hm');
  static DateFormat longTimeFormat = DateFormat('jm');
}