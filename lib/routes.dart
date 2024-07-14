import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/card_detail/card_detail.dart';
import 'screens/card_edit/card_edit.dart';
import 'screens/card_edit/card_edit.models.dart';
import 'screens/home/home.dart';

part 'routes.g.dart';

@TypedGoRoute<HomeScreenRoute>(
  path: '/',
  routes: [
    TypedGoRoute<CardEditRoute>(
      path: 'edit',
    ),
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
class CardEditRoute extends GoRouteData {
  const CardEditRoute({this.$extra});

  final CardDetailModel? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CardEdit(item: $extra);
  }
}

@immutable
class CardDetailRoute extends GoRouteData {
  const CardDetailRoute({
    required this.$extra,
  });

  final CardDetailModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CardDetail(card: $extra);
  }
}
