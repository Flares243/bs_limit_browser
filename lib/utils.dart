extension DateExtention on DateTime {
  bool isAtLeastOneDayAfter(DateTime date) {
    return isAfter(date) &&
        (day != date.day || month != date.month || year != date.year);
  }
}
