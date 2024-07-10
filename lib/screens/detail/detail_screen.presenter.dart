import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../home/home.model.dart';

part 'detail_screen.presenter.g.dart';

typedef DetailScreenVars = ({
  GlobalKey<FormState> formKey,
  TextEditingController titleController,
  TextEditingController hrefController,
  Function(DateTime duration) onSubmit,
});

@riverpod
DetailScreenVars detailScreenPres(DetailScreenPresRef ref,
    {CardUIModel? card}) {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final hrefController = TextEditingController();

  if (card != null) {
    titleController.text = card.title;
    hrefController.text = card.href;
  }

  Future<void> onSubmit(DateTime duration) async {
    if (formKey.currentState?.validate() ?? false) {
      final dir = await getApplicationDocumentsDirectory();

      final isar = await Isar.open(
        [CardUIModelSchema],
        directory: dir.path,
      );

      final newCard = CardUIModel(
        title: titleController.text,
        href: hrefController.text,
        duration: duration,
      );

      await isar.writeTxn(() async {
        await isar.cardUIModels.put(newCard);
      });
    }
  }

  return (
    formKey: formKey,
    titleController: titleController,
    hrefController: hrefController,
    onSubmit: onSubmit,
  );
}
