import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'card_edit_presenter.vars.g.dart';

typedef CardEditPresVars = ({
  GlobalKey<FormState> formKey,
  TextEditingController titleController,
  TextEditingController hrefController,
});

@riverpod
CardEditPresVars cardEditPresVars(CardEditPresVarsRef ref) {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final hrefController = TextEditingController();

  ref.onDispose(
    () {
      titleController.dispose();
      hrefController.dispose();
    },
  );

  return (
    formKey: formKey,
    titleController: titleController,
    hrefController: hrefController,
  );
}
