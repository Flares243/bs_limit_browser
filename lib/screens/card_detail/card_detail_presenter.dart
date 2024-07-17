import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:cron/cron.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../database/local/app_database.dart';
import '../../router.dart';
import '../card_edit/card_edit.models.dart';

part 'card_detail_presenter.g.dart';

@CopyWith()
class CardDetailState {
  const CardDetailState({
    required this.timeLeft,
  });

  final int timeLeft;
}

@riverpod
class CardDetailPres extends _$CardDetailPres {
  @override
  CardDetailState build() {
    _params = ref.watch(cardDetailParamsProvider);

    _schedule = _cron.schedule(
      Schedule.parse('* * * * * *'),
      () {
        final newTimeleft = state.timeLeft - 1;
        state = state.copyWith(timeLeft: newTimeleft);

        updateTimeleft(newTimeleft);

        if (state.timeLeft == 0) {
          _schedule?.cancel();
          onTimeup();
        }
      },
    );

    ref.onDispose(() async {
      await _schedule?.cancel();
      _cron.close();
    });

    return CardDetailState(
      timeLeft: _params.duration,
    );
  }

  final _cron = Cron();
  late CardDetailModel _params;
  ScheduledTask? _schedule;

  var _isUpdating = false;
  Future<void> updateTimeleft(int newTimeleft) async {
    if (_isUpdating) return;
    _isUpdating = true;

    final newCard = CardUIModelTableCompanion.insert(
      id: Value(_params.id),
      title: _params.title,
      url: _params.url,
      duration: _params.duration,
      timeLeft: newTimeleft,
      timeoutDate: Value.absentIfNull(newTimeleft == 0 ? DateTime.now() : null),
    );

    await ref.read(appDatabaseProvider).updateCardDetail(newCard);

    _isUpdating = false;
  }

  Future<void> onTimeup() async {
    updateTimeleft(0);

    final context =
        ref.read(appRouterProvider).configuration.navigatorKey.currentContext;

    if (context != null) {
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (dialogContext) => const AlertDialog(
            title: Text(
              'Times up!\nEnough for today~',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 26,
              ),
            ),
          ),
        );
      }

      if (context.mounted) {
        context.pop();
      }
    }
  }
}

@riverpod
CardDetailModel cardDetailParams(CardDetailParamsRef ref) {
  throw Exception();
}
