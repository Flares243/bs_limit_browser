// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_edit_presenter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CardEditStateCWProxy {
  CardEditState duration(Duration duration);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CardEditState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CardEditState(...).copyWith(id: 12, name: "My name")
  /// ````
  CardEditState call({
    Duration? duration,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCardEditState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCardEditState.copyWith.fieldName(...)`
class _$CardEditStateCWProxyImpl implements _$CardEditStateCWProxy {
  const _$CardEditStateCWProxyImpl(this._value);

  final CardEditState _value;

  @override
  CardEditState duration(Duration duration) => this(duration: duration);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CardEditState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CardEditState(...).copyWith(id: 12, name: "My name")
  /// ````
  CardEditState call({
    Object? duration = const $CopyWithPlaceholder(),
  }) {
    return CardEditState(
      duration: duration == const $CopyWithPlaceholder() || duration == null
          ? _value.duration
          // ignore: cast_nullable_to_non_nullable
          : duration as Duration,
    );
  }
}

extension $CardEditStateCopyWith on CardEditState {
  /// Returns a callable class that can be used as follows: `instanceOfCardEditState.copyWith(...)` or like so:`instanceOfCardEditState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CardEditStateCWProxy get copyWith => _$CardEditStateCWProxyImpl(this);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cardEditParamsHash() => r'52287dcd07a848ec5647c6d15578b4a9cec77968';

/// See also [cardEditParams].
@ProviderFor(cardEditParams)
final cardEditParamsProvider = AutoDisposeProvider<CardDetailModel?>.internal(
  cardEditParams,
  name: r'cardEditParamsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cardEditParamsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CardEditParamsRef = AutoDisposeProviderRef<CardDetailModel?>;
String _$cardEditPresHash() => r'249c0eb49afee91fcff8b1a42ae4c7ec8539217a';

/// See also [CardEditPres].
@ProviderFor(CardEditPres)
final cardEditPresProvider =
    AutoDisposeNotifierProvider<CardEditPres, CardEditState>.internal(
  CardEditPres.new,
  name: r'cardEditPresProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cardEditPresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CardEditPres = AutoDisposeNotifier<CardEditState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
