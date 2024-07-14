import 'package:drift/drift.dart';

import '../../screens/card_edit/card_edit.models.dart';

@UseRowClass(CardDetailModel)
class CardUIModelTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get url => text()();
  IntColumn get duration => integer()();
  DateTimeColumn get timeoutDate => dateTime().nullable()();
}
