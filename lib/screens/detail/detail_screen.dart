import 'package:bs_limit_browser/screens/detail/detail_screen.presenter.dart';
import 'package:bs_limit_browser/separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../home/home.model.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({
    this.item,
    super.key,
  });

  final CardUIModel? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenter = ref.watch(detailScreenPresProvider(card: item));

    final selectedDate = ValueNotifier(DateTime(0, 0, 0));

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: presenter.formKey,
          child: Column(
            children: [
              TextFormField(
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
              CustomDurationModal(date: selectedDate),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          presenter.onSubmit(selectedDate.value);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomDurationModal extends StatefulWidget {
  const CustomDurationModal({
    super.key,
    required this.date,
  });

  final ValueNotifier<DateTime> date;

  @override
  State<CustomDurationModal> createState() => _CustomDurationModalState();
}

class _CustomDurationModalState extends State<CustomDurationModal> {
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  late FixedExtentScrollController secondController;

  final dateFormat = DateFormat('HH:mm:ss');

  @override
  void initState() {
    super.initState();

    hourController = FixedExtentScrollController(
      initialItem: widget.date.value.hour,
    );
    minuteController = FixedExtentScrollController(
      initialItem: widget.date.value.minute,
    );
    secondController = FixedExtentScrollController(
      initialItem: widget.date.value.second,
    );
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    secondController.dispose();
    super.dispose();
  }

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
                    widget.date.value = widget.date.value.copyWith(hour: value);
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
                    widget.date.value =
                        widget.date.value.copyWith(minute: value);
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
                    widget.date.value =
                        widget.date.value.copyWith(second: value);
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
