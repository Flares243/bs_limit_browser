import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        children: [
          Slidable(
            endActionPane: ActionPane(
              extentRatio: .25,
              motion: const ScrollMotion(),
              children: [
                Container(
                  color: Colors.red,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                  ),
                ),
                Container(
                  color: Colors.yellow.shade800,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.symmetric(horizontal: BorderSide())),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Facebook'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
