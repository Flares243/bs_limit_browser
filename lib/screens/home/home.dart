import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes.dart';
import 'card_list_item.dart';
import 'home_presenter.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenter = ref.watch(homePresProvider.notifier);

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
            onRefresh: () async => presenter.init(),
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
                  (card) {
                    final isEnable = card.timeoutDate == null;

                    return CardListItem(
                      card: card,
                      isEnable: isEnable,
                      onCardPressed: () async {
                        if (context.mounted) {
                          await CardDetailRoute($extra: card).push(context);
                          presenter.init();
                        }
                      },
                      onDeletePressed: () => presenter.onDeleteCard(card),
                      onEditPressed: () async {
                        if (context.mounted) {
                          await CardEditRoute($extra: card).push(context);
                          presenter.init();
                        }
                      },
                    );
                  },
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
