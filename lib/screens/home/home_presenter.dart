import 'package:bs_limit_browser/constant.dart';
import 'package:bs_limit_browser/providers/shared_prefs_prov.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _sharedPrefs = ref.read(sharedPrefsProvider);

    init();

    return const HomeState(
      cardsList: [],
    );
  }

  late AppDatabase _database;
  late SharedPreferences _sharedPrefs;

  void init() {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final now = DateTime.now();

        var cardList = await _database.allTodoItems;

        final prevFetchedDate = DateTime.fromMillisecondsSinceEpoch(
          _sharedPrefs.getInt(lastFetchedTime) ?? 0,
        );

        if (now.isAtLeastOneDayAfter(prevFetchedDate)) {
          _sharedPrefs.setInt(
            lastFetchedTime,
            now.millisecondsSinceEpoch,
          );

          cardList = cardList.map(
            (e) {
              final newCard = e.copyWith(
                timeLeft: e.duration,
                timeoutDate: null,
              );

              _database.updateCardDetail(newCard.toCompanion);

              return newCard;
            },
          ).toList();
        }

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
