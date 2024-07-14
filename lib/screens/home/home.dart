import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../routes.dart';
import 'home_presenter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenter = ref.watch(homePresProvider.notifier);
    presenter.init();

    final dateFormat = DateFormat('HH:mm:ss');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Be productive! ✺◟(＾∇＾)◞✺'),
        toolbarHeight: kToolbarHeight + 24,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final cardList = ref.watch(homePresProvider.select(
            (value) => value.cardsList,
          ));

          return RefreshIndicator(
            onRefresh: () async {
              presenter.init();
            },
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 40,
              ),
              children: [
                ...cardList.map(
                  (card) => Slidable(
                    key: ValueKey(card.id),
                    closeOnScroll: true,
                    endActionPane: ActionPane(
                      extentRatio: .4,
                      motion: const ScrollMotion(),
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ColoredBox(
                                color: Colors.red,
                                child: IconButton(
                                  onPressed: () => presenter.onDeleteCard(card),
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                              ColoredBox(
                                color: Colors.yellow.shade700,
                                child: IconButton(
                                  onPressed: () async {
                                    await CardEditRoute($extra: card)
                                        .push(context);
                                    presenter.init();
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        CardDetailRoute($extra: card).go(context);
                      },
                      child: Card(
                        elevation: 3,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.title,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                card.url,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationThickness: .7,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    width: 24,
                                    height: 24,
                                    'assets/images/swipe_left.webp',
                                  ),
                                  Text(
                                    dateFormat.format(
                                      DateTime(0, 0, 0, 0, 0, card.duration),
                                    ),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                child!,
              ],
            ),
          );
        },
        child: GestureDetector(
          onTap: () async {
            await const CardEditRoute().push(context);
            presenter.init();
          },
          child: CustomPaint(
            painter: DashedPainter(
              color: Colors.grey,
              borderType: BorderType.RRect,
              dashPattern: [16, 16],
              radius: const Radius.circular(16),
              padding: const EdgeInsets.all(6),
              strokeWidth: 4,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.add,
                size: 56,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
