import 'package:isar/isar.dart';

part 'home.model.g.dart';

@collection
class CardUIModel {
  CardUIModel({
    required this.title,
    required this.href,
    required this.duration,
    this.timeoutDate,
  });

  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String title;

  @Index(type: IndexType.value)
  String href;

  DateTime duration;

  DateTime? timeoutDate;
}
