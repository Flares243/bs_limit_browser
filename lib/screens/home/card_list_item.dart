import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../card_edit/card_edit.models.dart';

class CardListItem extends StatefulWidget {
  const CardListItem({
    super.key,
    required this.card,
    required this.isEnable,
    this.onCardPressed,
    this.onDeletePressed,
    this.onEditPressed,
  });

  final CardDetailModel card;
  final bool isEnable;
  final VoidCallback? onCardPressed;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onEditPressed;

  @override
  State<CardListItem> createState() => _CardListItemState();
}

class _CardListItemState extends State<CardListItem>
    with SingleTickerProviderStateMixin {
  final dateFormat = DateFormat('HH:mm:ss');
  late SlidableController slideController;

  @override
  void initState() {
    super.initState();
    slideController = SlidableController(this);
  }

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      controller: slideController,
      key: ValueKey(widget.card.id),
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
                    onPressed: widget.onDeletePressed?.call,
                    icon: const Icon(Icons.delete),
                  ),
                ),
                ColoredBox(
                  color: Colors.yellow.shade700,
                  child: IconButton(
                    onPressed: () async {
                      await slideController.close();
                      widget.onEditPressed?.call();
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
        onTap: widget.isEnable
            ? () async {
                await slideController.close();
                widget.onCardPressed?.call();
              }
            : null,
        child: Card(
          elevation: 3,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      if (!widget.isEnable)
                        const WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.do_not_touch_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      TextSpan(
                        text: widget.card.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.card.url,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationThickness: .7,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      width: 24,
                      height: 24,
                      'assets/images/swipe_left.webp',
                    ),
                    Text(
                      dateFormat.format(
                        DateTime(0, 0, 0, 0, 0, widget.card.timeLeft),
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
