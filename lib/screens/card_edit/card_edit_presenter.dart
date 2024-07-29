import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../database/local/app_database.dart';
import 'card_edit.models.dart';
import 'card_edit_presenter.vars.dart';

part 'card_edit_presenter.g.dart';

@CopyWith()
class CardEditState {
  const CardEditState({
    required this.duration,
  });

  final Duration duration;
}

@riverpod
class CardEditPres extends _$CardEditPres {
  @override
  CardEditState build() {
    _vars = ref.watch(cardEditPresVarsProvider);
    _params = ref.watch(cardEditParamsProvider);

    _vars.titleController.text = _params?.title ?? '';
    _vars.hrefController.text = _params?.url ?? '';

    return CardEditState(
      duration: Duration(seconds: _params?.timeLeft ?? 0),
    );
  }

  late CardEditPresVars _vars;
  late CardDetailModel? _params;

  void setDuration(Duration duration) {
    state = state.copyWith(duration: duration);
  }

  Future<bool> onSubmit() async {
    if (_vars.formKey.currentState?.validate() ?? false) {
      final database = ref.read(appDatabaseProvider);

      final newCard = CardUIModelTableCompanion.insert(
        id: Value.absentIfNull(_params?.id),
        title: _vars.titleController.text,
        url: _vars.hrefController.text,
        duration: state.duration.inSeconds,
        timeLeft:
            _params != null ? _params!.timeLeft : state.duration.inSeconds,
      );

      _params != null
          ? await database.updateCardDetail(newCard)
          : await database.cardUIModelTable.insertOne(newCard);

      return true;
    }

    return false;
  }
}

@riverpod
CardDetailModel? cardEditParams(CardEditParamsRef ref) {
  throw Exception();
}
