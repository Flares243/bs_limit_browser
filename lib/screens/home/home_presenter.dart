import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../database/local/app_database.dart';
import '../../utils.dart';
import '../card_edit/card_edit.models.dart';

part 'home_presenter.g.dart';

@CopyWith()
class HomeState {
  const HomeState({
    required this.cardsList,
  });

  final List<CardDetailModel> cardsList;
}

@riverpod
class HomePres extends _$HomePres {
  @override
  HomeState build() {
    _database = ref.read(appDatabaseProvider);

    init();

    return const HomeState(
      cardsList: [],
    );
  }

  late AppDatabase _database;

  void init() {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        var cardList = await _database.allTodoItems;
        final now = DateTime.now();

        cardList = cardList.map(
          (e) {
            if (e.timeoutDate != null &&
                now.isAtLeastOneDayAfter(e.timeoutDate!)) {
              final newCard = e.copyWith(
                timeLeft: e.duration,
                timeoutDate: null,
              );

              _database.updateCardDetail(newCard.toCompanion);

              return newCard;
            }

            return e;
          },
        ).toList();

        state = state.copyWith(cardsList: cardList);
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
