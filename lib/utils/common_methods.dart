import 'package:intl/intl.dart';

String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
}

int generateUniqueNotificationId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(1 << 31);
}

 DateTime combineDateAndTime(String dateStr, String timeStr) {
    DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
    DateFormat timeFormat = DateFormat("h:mm a");

    DateTime date = dateFormat.parse(dateStr);
    DateTime time = timeFormat.parse(timeStr);

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

