// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_screen.presenter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$detailScreenPresHash() => r'97039addf532ac11f990473e8de0fbe553c1ccd9';

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

/// See also [detailScreenPres].
@ProviderFor(detailScreenPres)
const detailScreenPresProvider = DetailScreenPresFamily();

/// See also [detailScreenPres].
class DetailScreenPresFamily extends Family<DetailScreenVars> {
  /// See also [detailScreenPres].
  const DetailScreenPresFamily();

  /// See also [detailScreenPres].
  DetailScreenPresProvider call({
    CardUIModel? card,
  }) {
    return DetailScreenPresProvider(
      card: card,
    );
  }

  @override
  DetailScreenPresProvider getProviderOverride(
    covariant DetailScreenPresProvider provider,
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
  String? get name => r'detailScreenPresProvider';
}

/// See also [detailScreenPres].
class DetailScreenPresProvider extends AutoDisposeProvider<DetailScreenVars> {
  /// See also [detailScreenPres].
  DetailScreenPresProvider({
    CardUIModel? card,
  }) : this._internal(
          (ref) => detailScreenPres(
            ref as DetailScreenPresRef,
            card: card,
          ),
          from: detailScreenPresProvider,
          name: r'detailScreenPresProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$detailScreenPresHash,
          dependencies: DetailScreenPresFamily._dependencies,
          allTransitiveDependencies:
              DetailScreenPresFamily._allTransitiveDependencies,
          card: card,
        );

  DetailScreenPresProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.card,
  }) : super.internal();

  final CardUIModel? card;

  @override
  Override overrideWith(
    DetailScreenVars Function(DetailScreenPresRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DetailScreenPresProvider._internal(
        (ref) => create(ref as DetailScreenPresRef),
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
  AutoDisposeProviderElement<DetailScreenVars> createElement() {
    return _DetailScreenPresProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DetailScreenPresProvider && other.card == card;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, card.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DetailScreenPresRef on AutoDisposeProviderRef<DetailScreenVars> {
  /// The parameter `card` of this provider.
  CardUIModel? get card;
}

class _DetailScreenPresProviderElement
    extends AutoDisposeProviderElement<DetailScreenVars>
    with DetailScreenPresRef {
  _DetailScreenPresProviderElement(super.provider);

  @override
  CardUIModel? get card => (origin as DetailScreenPresProvider).card;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
