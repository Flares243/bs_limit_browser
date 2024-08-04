import 'dart:async';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pausable_timer/pausable_timer.dart';
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

    _timer = PausableTimer.periodic(
      const Duration(seconds: 1),
      () {
        if (state.timeLeft < 0) {
          onTimeup();
          return;
        }

        final newTimeleft = state.timeLeft - 1;
        state = state.copyWith(timeLeft: newTimeleft);

        updateTimeleft(newTimeleft);
      },
    );

    ref.onDispose(() async {
      _timer.cancel();
    });

    return CardDetailState(
      timeLeft: _params.timeLeft,
    );
  }

  late CardDetailModel _params;
  late PausableTimer _timer;

  Future<void> updateTimeleft(int newTimeleft) async {
    final newCard = CardUIModelTableCompanion.insert(
      id: Value(_params.id),
      title: _params.title,
      url: _params.url,
      duration: _params.duration,
      timeLeft: newTimeleft,
      timeoutDate: Value.absentIfNull(newTimeleft <= 0 ? DateTime.now() : null),
    );

    await ref.read(appDatabaseProvider).updateCardDetail(newCard);
  }

  Future<void> onTimeup() async {
    _timer.cancel();
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
                fontSize: 26,
                fontWeight: FontWeight.w600,
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

  void startCountdown() {
    _timer.start();
  }

  void pauseCountdown() {
    _timer.pause();
  }
}

@riverpod
CardDetailModel cardDetailParams(CardDetailParamsRef ref) {
  throw Exception();
}
