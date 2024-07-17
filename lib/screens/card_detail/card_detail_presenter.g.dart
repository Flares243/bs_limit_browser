// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_detail_presenter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CardDetailStateCWProxy {
  CardDetailState timeLeft(int timeLeft);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CardDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CardDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  CardDetailState call({
    int? timeLeft,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCardDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCardDetailState.copyWith.fieldName(...)`
class _$CardDetailStateCWProxyImpl implements _$CardDetailStateCWProxy {
  const _$CardDetailStateCWProxyImpl(this._value);

  final CardDetailState _value;

  @override
  CardDetailState timeLeft(int timeLeft) => this(timeLeft: timeLeft);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CardDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CardDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  CardDetailState call({
    Object? timeLeft = const $CopyWithPlaceholder(),
  }) {
    return CardDetailState(
      timeLeft: timeLeft == const $CopyWithPlaceholder() || timeLeft == null
          ? _value.timeLeft
          // ignore: cast_nullable_to_non_nullable
          : timeLeft as int,
    );
  }
}

extension $CardDetailStateCopyWith on CardDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfCardDetailState.copyWith(...)` or like so:`instanceOfCardDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CardDetailStateCWProxy get copyWith => _$CardDetailStateCWProxyImpl(this);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cardDetailParamsHash() => r'bd440bedd77ccd2171b4c4cb4e6989c39b14a27b';

/// See also [cardDetailParams].
@ProviderFor(cardDetailParams)
final cardDetailParamsProvider = AutoDisposeProvider<CardDetailModel>.internal(
  cardDetailParams,
  name: r'cardDetailParamsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cardDetailParamsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CardDetailParamsRef = AutoDisposeProviderRef<CardDetailModel>;
String _$cardDetailPresHash() => r'd1ae57b1fbf3aa8b5d2a0d5f40f344da8a36e040';

/// See also [CardDetailPres].
@ProviderFor(CardDetailPres)
final cardDetailPresProvider =
    AutoDisposeNotifierProvider<CardDetailPres, CardDetailState>.internal(
  CardDetailPres.new,
  name: r'cardDetailPresProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cardDetailPresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CardDetailPres = AutoDisposeNotifier<CardDetailState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
