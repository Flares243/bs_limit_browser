import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/detail/detail_screen.dart';
import 'screens/home/home.dart';
import 'screens/home/home.model.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeScreenRoute>(
  path: '/',
  routes: [
    TypedGoRoute<CardDetailRoute>(
      path: 'detail',
    )
  ],
)
@immutable
class HomeScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@immutable
class CardDetailRoute extends GoRouteData {
  const CardDetailRoute({this.$extra});

  final CardUIModel? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailScreen(item: $extra);
  }
}
