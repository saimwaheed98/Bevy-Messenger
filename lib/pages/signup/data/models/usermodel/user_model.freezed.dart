// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get pushToken => throw _privateConstructorUsedError;
  bool get subscription => throw _privateConstructorUsedError;
  String get lastActive => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  bool get userInternetState => throw _privateConstructorUsedError;
  List<dynamic> get blockedUsers => throw _privateConstructorUsedError;
  List<dynamic> get blockedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String phone,
      bool isOnline,
      String address,
      String imageUrl,
      String password,
      String createdAt,
      String pushToken,
      bool subscription,
      String lastActive,
      String city,
      String country,
      String state,
      bool userInternetState,
      List<dynamic> blockedUsers,
      List<dynamic> blockedBy});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? isOnline = null,
    Object? address = null,
    Object? imageUrl = null,
    Object? password = null,
    Object? createdAt = null,
    Object? pushToken = null,
    Object? subscription = null,
    Object? lastActive = null,
    Object? city = null,
    Object? country = null,
    Object? state = null,
    Object? userInternetState = null,
    Object? blockedUsers = null,
    Object? blockedBy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      pushToken: null == pushToken
          ? _value.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as bool,
      lastActive: null == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      userInternetState: null == userInternetState
          ? _value.userInternetState
          : userInternetState // ignore: cast_nullable_to_non_nullable
              as bool,
      blockedUsers: null == blockedUsers
          ? _value.blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      blockedBy: null == blockedBy
          ? _value.blockedBy
          : blockedBy // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      String phone,
      bool isOnline,
      String address,
      String imageUrl,
      String password,
      String createdAt,
      String pushToken,
      bool subscription,
      String lastActive,
      String city,
      String country,
      String state,
      bool userInternetState,
      List<dynamic> blockedUsers,
      List<dynamic> blockedBy});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? phone = null,
    Object? isOnline = null,
    Object? address = null,
    Object? imageUrl = null,
    Object? password = null,
    Object? createdAt = null,
    Object? pushToken = null,
    Object? subscription = null,
    Object? lastActive = null,
    Object? city = null,
    Object? country = null,
    Object? state = null,
    Object? userInternetState = null,
    Object? blockedUsers = null,
    Object? blockedBy = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      pushToken: null == pushToken
          ? _value.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String,
      subscription: null == subscription
          ? _value.subscription
          : subscription // ignore: cast_nullable_to_non_nullable
              as bool,
      lastActive: null == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      userInternetState: null == userInternetState
          ? _value.userInternetState
          : userInternetState // ignore: cast_nullable_to_non_nullable
              as bool,
      blockedUsers: null == blockedUsers
          ? _value._blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      blockedBy: null == blockedBy
          ? _value._blockedBy
          : blockedBy // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {this.id = '',
      this.name = '',
      this.email = '',
      this.phone = '',
      this.isOnline = true,
      this.address = '',
      this.imageUrl = '',
      this.password = '',
      this.createdAt = '',
      this.pushToken = '',
      this.subscription = false,
      this.lastActive = '',
      this.city = '',
      this.country = '',
      this.state = '',
      this.userInternetState = false,
      final List<dynamic> blockedUsers = const [],
      final List<dynamic> blockedBy = const []})
      : _blockedUsers = blockedUsers,
        _blockedBy = blockedBy;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final bool isOnline;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String imageUrl;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final String createdAt;
  @override
  @JsonKey()
  final String pushToken;
  @override
  @JsonKey()
  final bool subscription;
  @override
  @JsonKey()
  final String lastActive;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String country;
  @override
  @JsonKey()
  final String state;
  @override
  @JsonKey()
  final bool userInternetState;
  final List<dynamic> _blockedUsers;
  @override
  @JsonKey()
  List<dynamic> get blockedUsers {
    if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedUsers);
  }

  final List<dynamic> _blockedBy;
  @override
  @JsonKey()
  List<dynamic> get blockedBy {
    if (_blockedBy is EqualUnmodifiableListView) return _blockedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedBy);
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, isOnline: $isOnline, address: $address, imageUrl: $imageUrl, password: $password, createdAt: $createdAt, pushToken: $pushToken, subscription: $subscription, lastActive: $lastActive, city: $city, country: $country, state: $state, userInternetState: $userInternetState, blockedUsers: $blockedUsers, blockedBy: $blockedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.pushToken, pushToken) ||
                other.pushToken == pushToken) &&
            (identical(other.subscription, subscription) ||
                other.subscription == subscription) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.userInternetState, userInternetState) ||
                other.userInternetState == userInternetState) &&
            const DeepCollectionEquality()
                .equals(other._blockedUsers, _blockedUsers) &&
            const DeepCollectionEquality()
                .equals(other._blockedBy, _blockedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      phone,
      isOnline,
      address,
      imageUrl,
      password,
      createdAt,
      pushToken,
      subscription,
      lastActive,
      city,
      country,
      state,
      userInternetState,
      const DeepCollectionEquality().hash(_blockedUsers),
      const DeepCollectionEquality().hash(_blockedBy));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {final String id,
      final String name,
      final String email,
      final String phone,
      final bool isOnline,
      final String address,
      final String imageUrl,
      final String password,
      final String createdAt,
      final String pushToken,
      final bool subscription,
      final String lastActive,
      final String city,
      final String country,
      final String state,
      final bool userInternetState,
      final List<dynamic> blockedUsers,
      final List<dynamic> blockedBy}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  String get phone;
  @override
  bool get isOnline;
  @override
  String get address;
  @override
  String get imageUrl;
  @override
  String get password;
  @override
  String get createdAt;
  @override
  String get pushToken;
  @override
  bool get subscription;
  @override
  String get lastActive;
  @override
  String get city;
  @override
  String get country;
  @override
  String get state;
  @override
  bool get userInternetState;
  @override
  List<dynamic> get blockedUsers;
  @override
  List<dynamic> get blockedBy;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
