import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../database/local/app_database.dart';
import '../card_edit/card_edit.models.dart';

part 'home_presenter.g.dart';

@CopyWith()
class HomeState {
  HomeState({
    required this.cardsList,
  });

  final List<CardDetailModel> cardsList;
}

@riverpod
class HomePres extends _$HomePres {
  @override
  HomeState build() {
    _database = ref.read(appDatabaseProvider);

    return HomeState(
      cardsList: [],
    );
  }

  late AppDatabase _database;

  void init() {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final cardList = await _database.allTodoItems;

        state = state.copyWith(
          cardsList: cardList,
        );
      },
    );
  }

  Future<void> onDeleteCard(CardDetailModel item) async {
    final result = await _database.deleteCardDetail(item.id);

    if (result > 0) {
      init();
    }
  }
}
