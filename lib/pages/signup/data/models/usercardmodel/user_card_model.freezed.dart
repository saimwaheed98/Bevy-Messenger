// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserCardModel _$UserCardModelFromJson(Map<String, dynamic> json) {
  return _UserCardModel.fromJson(json);
}

/// @nodoc
mixin _$UserCardModel {
  String get cardNumber => throw _privateConstructorUsedError;
  String get cardExp => throw _privateConstructorUsedError;
  String get cardCVC => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCardModelCopyWith<UserCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCardModelCopyWith<$Res> {
  factory $UserCardModelCopyWith(
          UserCardModel value, $Res Function(UserCardModel) then) =
      _$UserCardModelCopyWithImpl<$Res, UserCardModel>;
  @useResult
  $Res call({String cardNumber, String cardExp, String cardCVC});
}

/// @nodoc
class _$UserCardModelCopyWithImpl<$Res, $Val extends UserCardModel>
    implements $UserCardModelCopyWith<$Res> {
  _$UserCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardNumber = null,
    Object? cardExp = null,
    Object? cardCVC = null,
  }) {
    return _then(_value.copyWith(
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      cardExp: null == cardExp
          ? _value.cardExp
          : cardExp // ignore: cast_nullable_to_non_nullable
              as String,
      cardCVC: null == cardCVC
          ? _value.cardCVC
          : cardCVC // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserCardModelImplCopyWith<$Res>
    implements $UserCardModelCopyWith<$Res> {
  factory _$$UserCardModelImplCopyWith(
          _$UserCardModelImpl value, $Res Function(_$UserCardModelImpl) then) =
      __$$UserCardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cardNumber, String cardExp, String cardCVC});
}

/// @nodoc
class __$$UserCardModelImplCopyWithImpl<$Res>
    extends _$UserCardModelCopyWithImpl<$Res, _$UserCardModelImpl>
    implements _$$UserCardModelImplCopyWith<$Res> {
  __$$UserCardModelImplCopyWithImpl(
      _$UserCardModelImpl _value, $Res Function(_$UserCardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardNumber = null,
    Object? cardExp = null,
    Object? cardCVC = null,
  }) {
    return _then(_$UserCardModelImpl(
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String,
      cardExp: null == cardExp
          ? _value.cardExp
          : cardExp // ignore: cast_nullable_to_non_nullable
              as String,
      cardCVC: null == cardCVC
          ? _value.cardCVC
          : cardCVC // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserCardModelImpl implements _UserCardModel {
  _$UserCardModelImpl(
      {this.cardNumber = "", this.cardExp = "", this.cardCVC = ""});

  factory _$UserCardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserCardModelImplFromJson(json);

  @override
  @JsonKey()
  final String cardNumber;
  @override
  @JsonKey()
  final String cardExp;
  @override
  @JsonKey()
  final String cardCVC;

  @override
  String toString() {
    return 'UserCardModel(cardNumber: $cardNumber, cardExp: $cardExp, cardCVC: $cardCVC)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCardModelImpl &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.cardExp, cardExp) || other.cardExp == cardExp) &&
            (identical(other.cardCVC, cardCVC) || other.cardCVC == cardCVC));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cardNumber, cardExp, cardCVC);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCardModelImplCopyWith<_$UserCardModelImpl> get copyWith =>
      __$$UserCardModelImplCopyWithImpl<_$UserCardModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserCardModelImplToJson(
      this,
    );
  }
}

abstract class _UserCardModel implements UserCardModel {
  factory _UserCardModel(
      {final String cardNumber,
      final String cardExp,
      final String cardCVC}) = _$UserCardModelImpl;

  factory _UserCardModel.fromJson(Map<String, dynamic> json) =
      _$UserCardModelImpl.fromJson;

  @override
  String get cardNumber;
  @override
  String get cardExp;
  @override
  String get cardCVC;
  @override
  @JsonKey(ignore: true)
  _$$UserCardModelImplCopyWith<_$UserCardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
