enum TimeMeasurement {
  seconds(label: 'Giây'),
  minutes(label: 'Phút'),
  hours(label: 'Giờ'),
  days(label: 'Ngày'),
  ;

  const TimeMeasurement({
    required this.label,
  });

  final String label;
}
