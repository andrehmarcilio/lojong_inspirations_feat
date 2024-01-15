extension DateTimeExtensions on DateTime {
  int get daysPassed {
    return DateTime.now().difference(this).inDays;
  }
}
