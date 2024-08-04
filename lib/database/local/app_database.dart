import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../screens/card_edit/card_edit.models.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [CardUIModelTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'bg_limit_browser'));

  @override
  int get schemaVersion => 1;

  Future<List<CardDetailModel>> get allTodoItems =>
      select(cardUIModelTable).get();

  Future<int> addCardDetail(CardUIModelTableCompanion item) {
    return into(cardUIModelTable).insert(item);
  }

  Future<int> updateCardDetail(CardUIModelTableCompanion item) {
    return (update(cardUIModelTable)..where((t) => t.id.equals(item.id.value)))
        .write(item);
  }

  Future<int> deleteCardDetail(int id) {
    return (delete(cardUIModelTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteEverything() {
    return transaction(() async {
      // you only need this if you've manually enabled foreign keys
      // await customStatement('PRAGMA foreign_keys = OFF');
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);

  return database;
}
