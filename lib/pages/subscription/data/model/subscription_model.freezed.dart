// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) {
  return _SubscriptionModel.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionModel {
  String get userId => throw _privateConstructorUsedError;
  String get endingData => throw _privateConstructorUsedError;
  String get subscribedData => throw _privateConstructorUsedError;
  String get subscriptionId => throw _privateConstructorUsedError;
  String get subscribedGroupId => throw _privateConstructorUsedError;
  String get subscribedGroupName => throw _privateConstructorUsedError;
  bool get subscriptionStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubscriptionModelCopyWith<SubscriptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionModelCopyWith<$Res> {
  factory $SubscriptionModelCopyWith(
          SubscriptionModel value, $Res Function(SubscriptionModel) then) =
      _$SubscriptionModelCopyWithImpl<$Res, SubscriptionModel>;
  @useResult
  $Res call(
      {String userId,
      String endingData,
      String subscribedData,
      String subscriptionId,
      String subscribedGroupId,
      String subscribedGroupName,
      bool subscriptionStatus});
}

/// @nodoc
class _$SubscriptionModelCopyWithImpl<$Res, $Val extends SubscriptionModel>
    implements $SubscriptionModelCopyWith<$Res> {
  _$SubscriptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? endingData = null,
    Object? subscribedData = null,
    Object? subscriptionId = null,
    Object? subscribedGroupId = null,
    Object? subscribedGroupName = null,
    Object? subscriptionStatus = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      endingData: null == endingData
          ? _value.endingData
          : endingData // ignore: cast_nullable_to_non_nullable
              as String,
      subscribedData: null == subscribedData
          ? _value.subscribedData
          : subscribedData // ignore: cast_nullable_to_non_nullable
              as String,
      subscriptionId: null == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String,
      subscribedGroupId: null == subscribedGroupId
          ? _value.subscribedGroupId
          : subscribedGroupId // ignore: cast_nullable_to_non_nullable
              as String,
      subscribedGroupName: null == subscribedGroupName
          ? _value.subscribedGroupName
          : subscribedGroupName // ignore: cast_nullable_to_non_nullable
              as String,
      subscriptionStatus: null == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionModelImplCopyWith<$Res>
    implements $SubscriptionModelCopyWith<$Res> {
  factory _$$SubscriptionModelImplCopyWith(_$SubscriptionModelImpl value,
          $Res Function(_$SubscriptionModelImpl) then) =
      __$$SubscriptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String endingData,
      String subscribedData,
      String subscriptionId,
      String subscribedGroupId,
      String subscribedGroupName,
      bool subscriptionStatus});
}

/// @nodoc
class __$$SubscriptionModelImplCopyWithImpl<$Res>
    extends _$SubscriptionModelCopyWithImpl<$Res, _$SubscriptionModelImpl>
    implements _$$SubscriptionModelImplCopyWith<$Res> {
  __$$SubscriptionModelImplCopyWithImpl(_$SubscriptionModelImpl _value,
      $Res Function(_$SubscriptionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? endingData = null,
    Object? subscribedData = null,
    Object? subscriptionId = null,
    Object? subscribedGroupId = null,
    Object? subscribedGroupName = null,
    Object? subscriptionStatus = null,
  }) {
    return _then(_$SubscriptionModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      endingData: null == endingData
          ? _value.endingData
          : endingData // ignore: cast_nullable_to_non_nullable
              as String,
      subscribedData: null == subscribedData
          ? _value.subscribedData
          : subscribedData // ignore: cast_nullable_to_non_nullable
              as String,
      subscriptionId: null == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String,
      subscribedGroupId: null == subscribedGroupId
          ? _value.subscribedGroupId
          : subscribedGroupId // ignore: cast_nullable_to_non_nullable
              as String,
      subscribedGroupName: null == subscribedGroupName
          ? _value.subscribedGroupName
          : subscribedGroupName // ignore: cast_nullable_to_non_nullable
              as String,
      subscriptionStatus: null == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionModelImpl implements _SubscriptionModel {
  const _$SubscriptionModelImpl(
      {this.userId = "",
      this.endingData = "",
      this.subscribedData = "",
      this.subscriptionId = "",
      this.subscribedGroupId = "",
      this.subscribedGroupName = "",
      this.subscriptionStatus = true});

  factory _$SubscriptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionModelImplFromJson(json);

  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final String endingData;
  @override
  @JsonKey()
  final String subscribedData;
  @override
  @JsonKey()
  final String subscriptionId;
  @override
  @JsonKey()
  final String subscribedGroupId;
  @override
  @JsonKey()
  final String subscribedGroupName;
  @override
  @JsonKey()
  final bool subscriptionStatus;

  @override
  String toString() {
    return 'SubscriptionModel(userId: $userId, endingData: $endingData, subscribedData: $subscribedData, subscriptionId: $subscriptionId, subscribedGroupId: $subscribedGroupId, subscribedGroupName: $subscribedGroupName, subscriptionStatus: $subscriptionStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.endingData, endingData) ||
                other.endingData == endingData) &&
            (identical(other.subscribedData, subscribedData) ||
                other.subscribedData == subscribedData) &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            (identical(other.subscribedGroupId, subscribedGroupId) ||
                other.subscribedGroupId == subscribedGroupId) &&
            (identical(other.subscribedGroupName, subscribedGroupName) ||
                other.subscribedGroupName == subscribedGroupName) &&
            (identical(other.subscriptionStatus, subscriptionStatus) ||
                other.subscriptionStatus == subscriptionStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      endingData,
      subscribedData,
      subscriptionId,
      subscribedGroupId,
      subscribedGroupName,
      subscriptionStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionModelImplCopyWith<_$SubscriptionModelImpl> get copyWith =>
      __$$SubscriptionModelImplCopyWithImpl<_$SubscriptionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionModelImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionModel implements SubscriptionModel {
  const factory _SubscriptionModel(
      {final String userId,
      final String endingData,
      final String subscribedData,
      final String subscriptionId,
      final String subscribedGroupId,
      final String subscribedGroupName,
      final bool subscriptionStatus}) = _$SubscriptionModelImpl;

  factory _SubscriptionModel.fromJson(Map<String, dynamic> json) =
      _$SubscriptionModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get endingData;
  @override
  String get subscribedData;
  @override
  String get subscriptionId;
  @override
  String get subscribedGroupId;
  @override
  String get subscribedGroupName;
  @override
  bool get subscriptionStatus;
  @override
  @JsonKey(ignore: true)
  _$$SubscriptionModelImplCopyWith<_$SubscriptionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
