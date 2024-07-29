// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_edit.models.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CardDetailModelCWProxy {
  CardDetailModel id(int id);

  CardDetailModel title(String title);

  CardDetailModel url(String url);

  CardDetailModel duration(int duration);

  CardDetailModel timeLeft(int timeLeft);

  CardDetailModel timeoutDate(DateTime? timeoutDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CardDetailModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CardDetailModel(...).copyWith(id: 12, name: "My name")
  /// ````
  CardDetailModel call({
    int? id,
    String? title,
    String? url,
    int? duration,
    int? timeLeft,
    DateTime? timeoutDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCardDetailModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCardDetailModel.copyWith.fieldName(...)`
class _$CardDetailModelCWProxyImpl implements _$CardDetailModelCWProxy {
  const _$CardDetailModelCWProxyImpl(this._value);

  final CardDetailModel _value;

  @override
  CardDetailModel id(int id) => this(id: id);

  @override
  CardDetailModel title(String title) => this(title: title);

  @override
  CardDetailModel url(String url) => this(url: url);

  @override
  CardDetailModel duration(int duration) => this(duration: duration);

  @override
  CardDetailModel timeLeft(int timeLeft) => this(timeLeft: timeLeft);

  @override
  CardDetailModel timeoutDate(DateTime? timeoutDate) =>
      this(timeoutDate: timeoutDate);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CardDetailModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CardDetailModel(...).copyWith(id: 12, name: "My name")
  /// ````
  CardDetailModel call({
    Object? id = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? duration = const $CopyWithPlaceholder(),
    Object? timeLeft = const $CopyWithPlaceholder(),
    Object? timeoutDate = const $CopyWithPlaceholder(),
  }) {
    return CardDetailModel(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      url: url == const $CopyWithPlaceholder() || url == null
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      duration: duration == const $CopyWithPlaceholder() || duration == null
          ? _value.duration
          // ignore: cast_nullable_to_non_nullable
          : duration as int,
      timeLeft: timeLeft == const $CopyWithPlaceholder() || timeLeft == null
          ? _value.timeLeft
          // ignore: cast_nullable_to_non_nullable
          : timeLeft as int,
      timeoutDate: timeoutDate == const $CopyWithPlaceholder()
          ? _value.timeoutDate
          // ignore: cast_nullable_to_non_nullable
          : timeoutDate as DateTime?,
    );
  }
}

extension $CardDetailModelCopyWith on CardDetailModel {
  /// Returns a callable class that can be used as follows: `instanceOfCardDetailModel.copyWith(...)` or like so:`instanceOfCardDetailModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CardDetailModelCWProxy get copyWith => _$CardDetailModelCWProxyImpl(this);
}
