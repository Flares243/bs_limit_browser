import 'package:bs_limit_browser/router.dart';
import 'package:bs_limit_browser/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(appRouterProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
