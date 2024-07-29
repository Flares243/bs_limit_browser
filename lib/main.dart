import 'dart:async';

import 'package:bs_limit_browser/providers/shared_prefs_prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';
import 'router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefs = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [
      sharedPrefsProvider.overrideWithValue(sharedPrefs),
    ],
  );

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(appDatabaseProvider).deleteEverything();

    // return WidgetsApp(
    //   color: Colors.blue,
    //   builder: (context, child) {
    //     return const Placeholder();
    //   },
    // );

    final router = ref.read(appRouterProvider);

    return MaterialApp.router(
      title: 'Limit browser',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
