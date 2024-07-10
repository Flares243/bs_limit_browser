import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Be productive! ✺◟(＾∇＾)◞✺'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 40,
        ),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [
          ...List.generate(
            3,
            (index) {
              return Slidable(
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
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                          ColoredBox(
                            color: Colors.yellow.shade700,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Facebook',
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Text(
                          'https://facebook.com',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '45:00',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Image.asset(
                              width: 24,
                              height: 24,
                              'assets/images/swipe_left.webp',
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              const CardDetailRoute().go(context);
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
          )
        ],
      ),
    );
  }
}
