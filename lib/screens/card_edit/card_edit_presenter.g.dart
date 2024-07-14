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

String _$cardEditPresHash() => r'34aa1bf23e0ebd235cb1b14d339aa903fb9045e7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CardEditPres
    extends BuildlessAutoDisposeNotifier<CardEditState> {
  late final CardDetailModel? card;

  CardEditState build({
    CardDetailModel? card,
  });
}

/// See also [CardEditPres].
@ProviderFor(CardEditPres)
const cardEditPresProvider = CardEditPresFamily();

/// See also [CardEditPres].
class CardEditPresFamily extends Family<CardEditState> {
  /// See also [CardEditPres].
  const CardEditPresFamily();

  /// See also [CardEditPres].
  CardEditPresProvider call({
    CardDetailModel? card,
  }) {
    return CardEditPresProvider(
      card: card,
    );
  }

  @override
  CardEditPresProvider getProviderOverride(
    covariant CardEditPresProvider provider,
  ) {
    return call(
      card: provider.card,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cardEditPresProvider';
}

/// See also [CardEditPres].
class CardEditPresProvider
    extends AutoDisposeNotifierProviderImpl<CardEditPres, CardEditState> {
  /// See also [CardEditPres].
  CardEditPresProvider({
    CardDetailModel? card,
  }) : this._internal(
          () => CardEditPres()..card = card,
          from: cardEditPresProvider,
          name: r'cardEditPresProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cardEditPresHash,
          dependencies: CardEditPresFamily._dependencies,
          allTransitiveDependencies:
              CardEditPresFamily._allTransitiveDependencies,
          card: card,
        );

  CardEditPresProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.card,
  }) : super.internal();

  final CardDetailModel? card;

  @override
  CardEditState runNotifierBuild(
    covariant CardEditPres notifier,
  ) {
    return notifier.build(
      card: card,
    );
  }

  @override
  Override overrideWith(CardEditPres Function() create) {
    return ProviderOverride(
      origin: this,
      override: CardEditPresProvider._internal(
        () => create()..card = card,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        card: card,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CardEditPres, CardEditState>
      createElement() {
    return _CardEditPresProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CardEditPresProvider && other.card == card;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, card.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CardEditPresRef on AutoDisposeNotifierProviderRef<CardEditState> {
  /// The parameter `card` of this provider.
  CardDetailModel? get card;
}

class _CardEditPresProviderElement
    extends AutoDisposeNotifierProviderElement<CardEditPres, CardEditState>
    with CardEditPresRef {
  _CardEditPresProviderElement(super.provider);

  @override
  CardDetailModel? get card => (origin as CardEditPresProvider).card;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
