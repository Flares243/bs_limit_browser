import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:drift/drift.dart';

import '../../database/local/app_database.dart';

part 'card_edit.models.g.dart';

@CopyWith()
class CardDetailModel {
  const CardDetailModel({
    required this.id,
    required this.title,
    required this.url,
    required this.duration,
    required this.timeLeft,
    this.timeoutDate,
  });

  final int id;
  final String title;
  final String url;
  final int duration;
  final int timeLeft;
  final DateTime? timeoutDate;
}

extension CardDetailModelExt on CardDetailModel {
  get toCompanion => CardUIModelTableCompanion(
        id: Value.absentIfNull(id),
        title: Value.absentIfNull(title),
        url: Value.absentIfNull(url),
        duration: Value.absentIfNull(duration),
        timeLeft: Value.absentIfNull(timeLeft),
        timeoutDate: Value.absentIfNull(timeoutDate),
      );
}
