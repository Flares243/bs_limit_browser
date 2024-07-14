class CardDetailModel {
  CardDetailModel({
    required this.id,
    required this.title,
    required this.url,
    required this.duration,
    this.timeoutDate,
  });

  final int id;
  final String title;
  final String url;
  final int duration;
  DateTime? timeoutDate;
}
