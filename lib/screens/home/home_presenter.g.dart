// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_presenter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeStateCWProxy {
  HomeState cardsList(List<CardDetailModel> cardsList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    List<CardDetailModel>? cardsList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHomeState.copyWith.fieldName(...)`
class _$HomeStateCWProxyImpl implements _$HomeStateCWProxy {
  const _$HomeStateCWProxyImpl(this._value);

  final HomeState _value;

  @override
  HomeState cardsList(List<CardDetailModel> cardsList) =>
      this(cardsList: cardsList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    Object? cardsList = const $CopyWithPlaceholder(),
  }) {
    return HomeState(
      cardsList: cardsList == const $CopyWithPlaceholder() || cardsList == null
          ? _value.cardsList
          // ignore: cast_nullable_to_non_nullable
          : cardsList as List<CardDetailModel>,
    );
  }
}

extension $HomeStateCopyWith on HomeState {
  /// Returns a callable class that can be used as follows: `instanceOfHomeState.copyWith(...)` or like so:`instanceOfHomeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeStateCWProxy get copyWith => _$HomeStateCWProxyImpl(this);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homePresHash() => r'e28ec70594632d19b079e31c2ee40ce748644a83';

/// See also [HomePres].
@ProviderFor(HomePres)
final homePresProvider =
    AutoDisposeNotifierProvider<HomePres, HomeState>.internal(
  HomePres.new,
  name: r'homePresProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$homePresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomePres = AutoDisposeNotifier<HomeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
