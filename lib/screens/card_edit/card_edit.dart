import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../separator.dart';
import 'card_edit.models.dart';
import 'card_edit_presenter.dart';
import 'card_edit_presenter.vars.dart';

class CardEdit extends ConsumerWidget {
  const CardEdit({
    this.item,
    super.key,
  });

  final CardDetailModel? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = cardEditPresProvider(card: item);

    final vars = ref.read(cardEditPresVarsProvider);
    final presenter = ref.watch(provider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: vars.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: vars.titleController,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: const InputDecoration(
                    label: Text('Label:'),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please fill this field.';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: vars.hrefController,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: const InputDecoration(
                    label: Text('Url:'),
                    hintText: 'https://example.com',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please fill this field.';
                    }

                    return null;
                  },
                ),
                CustomDurationModal(
                  initialDate: DateTime(0, 0, 0, 0, 0, item?.duration ?? 0),
                  onDateChanged: (duration) => presenter.setDuration(duration),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await presenter.onSubmit();

          if (context.mounted && result) {
            context.pop(true);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomDurationModal extends StatefulWidget {
  const CustomDurationModal({
    super.key,
    required this.initialDate,
    this.onDateChanged,
  });

  final DateTime initialDate;
  final void Function(Duration duration)? onDateChanged;

  @override
  State<CustomDurationModal> createState() => _CustomDurationModalState();
}

class _CustomDurationModalState extends State<CustomDurationModal> {
  @override
  void initState() {
    super.initState();

    hourController = FixedExtentScrollController(
      initialItem: widget.initialDate.hour,
    );
    minuteController = FixedExtentScrollController(
      initialItem: widget.initialDate.minute,
    );
    secondController = FixedExtentScrollController(
      initialItem: widget.initialDate.second,
    );
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    secondController.dispose();
    super.dispose();
  }

  void onDateChange() {
    widget.onDateChanged?.call(
      Duration(
        hours: hourController.selectedItem,
        minutes: minuteController.selectedItem,
        seconds: secondController.selectedItem,
      ),
    );
  }

  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  late FixedExtentScrollController secondController;

  final dateFormat = DateFormat('HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 150,
                child: CupertinoPicker(
                  itemExtent: 50,
                  looping: true,
                  scrollController: hourController,
                  onSelectedItemChanged: (value) {
                    onDateChange();
                  },
                  children: List.generate(
                    24,
                    (index) => Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$index'.padLeft(2, '0'),
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                height: 150,
                child: CupertinoPicker(
                  itemExtent: 50,
                  looping: true,
                  scrollController: minuteController,
                  onSelectedItemChanged: (value) {
                    onDateChange();
                  },
                  children: List.generate(
                    60,
                    (index) => Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$index'.padLeft(2, '0'),
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                height: 150,
                child: CupertinoPicker(
                  itemExtent: 50,
                  looping: true,
                  scrollController: secondController,
                  onSelectedItemChanged: (value) {
                    onDateChange();
                  },
                  children: List.generate(
                    60,
                    (index) => Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$index'.padLeft(2, '0'),
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ),
              ),
            ]
                .separator(const Text(':', style: TextStyle(fontSize: 32)))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Row(
            children: [
              DateTime(0, 0, 0, 1, 0, 0),
              DateTime(0, 0, 0, 0, 45, 0),
              DateTime(0, 0, 0, 0, 30, 0)
            ]
                .map(
                  (e) => Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: GestureDetector(
                        onTap: () {
                          hourController.jumpToItem(e.hour);
                          minuteController.jumpToItem(e.minute);
                          secondController.jumpToItem(e.second);
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: const CircleBorder(),
                            color: Colors.black.withOpacity(.2),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            dateFormat.format(e),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .separator(const SizedBox(width: 16))
                .toList(),
          ),
        )
      ],
    );
  }
}
