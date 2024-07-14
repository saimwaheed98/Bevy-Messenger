// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) {
  return _GroupModel.fromJson(json);
}

/// @nodoc
mixin _$GroupModel {
// group data
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get premium => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String get updatedBy => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get notification => throw _privateConstructorUsedError;
  String get lastMessage => throw _privateConstructorUsedError;
  String get lastMessageTime => throw _privateConstructorUsedError;
  String get lastMessageUserImage => throw _privateConstructorUsedError;
  List<String> get members => throw _privateConstructorUsedError;
  List<String> get onlineUsers => throw _privateConstructorUsedError;
  List<String> get blockedUsers => throw _privateConstructorUsedError;
  List<String> get unreadMessageUsers =>
      throw _privateConstructorUsedError; // group admin data
  String get adminId => throw _privateConstructorUsedError;
  String get adminName => throw _privateConstructorUsedError;
  String get adminImage => throw _privateConstructorUsedError; //group category
  String get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupModelCopyWith<GroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupModelCopyWith<$Res> {
  factory $GroupModelCopyWith(
          GroupModel value, $Res Function(GroupModel) then) =
      _$GroupModelCopyWithImpl<$Res, GroupModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      bool premium,
      String imageUrl,
      String createdAt,
      String updatedAt,
      String createdBy,
      String updatedBy,
      String description,
      bool notification,
      String lastMessage,
      String lastMessageTime,
      String lastMessageUserImage,
      List<String> members,
      List<String> onlineUsers,
      List<String> blockedUsers,
      List<String> unreadMessageUsers,
      String adminId,
      String adminName,
      String adminImage,
      String category});
}

/// @nodoc
class _$GroupModelCopyWithImpl<$Res, $Val extends GroupModel>
    implements $GroupModelCopyWith<$Res> {
  _$GroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? premium = null,
    Object? imageUrl = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? updatedBy = null,
    Object? description = null,
    Object? notification = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? lastMessageUserImage = null,
    Object? members = null,
    Object? onlineUsers = null,
    Object? blockedUsers = null,
    Object? unreadMessageUsers = null,
    Object? adminId = null,
    Object? adminName = null,
    Object? adminImage = null,
    Object? category = null,
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
      premium: null == premium
          ? _value.premium
          : premium // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedBy: null == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as bool,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageUserImage: null == lastMessageUserImage
          ? _value.lastMessageUserImage
          : lastMessageUserImage // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      onlineUsers: null == onlineUsers
          ? _value.onlineUsers
          : onlineUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      blockedUsers: null == blockedUsers
          ? _value.blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unreadMessageUsers: null == unreadMessageUsers
          ? _value.unreadMessageUsers
          : unreadMessageUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      adminId: null == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String,
      adminName: null == adminName
          ? _value.adminName
          : adminName // ignore: cast_nullable_to_non_nullable
              as String,
      adminImage: null == adminImage
          ? _value.adminImage
          : adminImage // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupModelImplCopyWith<$Res>
    implements $GroupModelCopyWith<$Res> {
  factory _$$GroupModelImplCopyWith(
          _$GroupModelImpl value, $Res Function(_$GroupModelImpl) then) =
      __$$GroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      bool premium,
      String imageUrl,
      String createdAt,
      String updatedAt,
      String createdBy,
      String updatedBy,
      String description,
      bool notification,
      String lastMessage,
      String lastMessageTime,
      String lastMessageUserImage,
      List<String> members,
      List<String> onlineUsers,
      List<String> blockedUsers,
      List<String> unreadMessageUsers,
      String adminId,
      String adminName,
      String adminImage,
      String category});
}

/// @nodoc
class __$$GroupModelImplCopyWithImpl<$Res>
    extends _$GroupModelCopyWithImpl<$Res, _$GroupModelImpl>
    implements _$$GroupModelImplCopyWith<$Res> {
  __$$GroupModelImplCopyWithImpl(
      _$GroupModelImpl _value, $Res Function(_$GroupModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? premium = null,
    Object? imageUrl = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? updatedBy = null,
    Object? description = null,
    Object? notification = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? lastMessageUserImage = null,
    Object? members = null,
    Object? onlineUsers = null,
    Object? blockedUsers = null,
    Object? unreadMessageUsers = null,
    Object? adminId = null,
    Object? adminName = null,
    Object? adminImage = null,
    Object? category = null,
  }) {
    return _then(_$GroupModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      premium: null == premium
          ? _value.premium
          : premium // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      updatedBy: null == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as bool,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageUserImage: null == lastMessageUserImage
          ? _value.lastMessageUserImage
          : lastMessageUserImage // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      onlineUsers: null == onlineUsers
          ? _value._onlineUsers
          : onlineUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      blockedUsers: null == blockedUsers
          ? _value._blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      unreadMessageUsers: null == unreadMessageUsers
          ? _value._unreadMessageUsers
          : unreadMessageUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      adminId: null == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String,
      adminName: null == adminName
          ? _value.adminName
          : adminName // ignore: cast_nullable_to_non_nullable
              as String,
      adminImage: null == adminImage
          ? _value.adminImage
          : adminImage // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupModelImpl implements _GroupModel {
  const _$GroupModelImpl(
      {this.id = "",
      this.name = "",
      this.premium = true,
      this.imageUrl = "",
      this.createdAt = "",
      this.updatedAt = "",
      this.createdBy = "",
      this.updatedBy = "",
      this.description = "",
      this.notification = true,
      this.lastMessage = "",
      this.lastMessageTime = "",
      this.lastMessageUserImage = "",
      final List<String> members = const [],
      final List<String> onlineUsers = const [],
      final List<String> blockedUsers = const [],
      final List<String> unreadMessageUsers = const [],
      this.adminId = "",
      this.adminName = "",
      this.adminImage = "",
      this.category = ""})
      : _members = members,
        _onlineUsers = onlineUsers,
        _blockedUsers = blockedUsers,
        _unreadMessageUsers = unreadMessageUsers;

  factory _$GroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupModelImplFromJson(json);

// group data
  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final bool premium;
  @override
  @JsonKey()
  final String imageUrl;
  @override
  @JsonKey()
  final String createdAt;
  @override
  @JsonKey()
  final String updatedAt;
  @override
  @JsonKey()
  final String createdBy;
  @override
  @JsonKey()
  final String updatedBy;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final bool notification;
  @override
  @JsonKey()
  final String lastMessage;
  @override
  @JsonKey()
  final String lastMessageTime;
  @override
  @JsonKey()
  final String lastMessageUserImage;
  final List<String> _members;
  @override
  @JsonKey()
  List<String> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  final List<String> _onlineUsers;
  @override
  @JsonKey()
  List<String> get onlineUsers {
    if (_onlineUsers is EqualUnmodifiableListView) return _onlineUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_onlineUsers);
  }

  final List<String> _blockedUsers;
  @override
  @JsonKey()
  List<String> get blockedUsers {
    if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedUsers);
  }

  final List<String> _unreadMessageUsers;
  @override
  @JsonKey()
  List<String> get unreadMessageUsers {
    if (_unreadMessageUsers is EqualUnmodifiableListView)
      return _unreadMessageUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unreadMessageUsers);
  }

// group admin data
  @override
  @JsonKey()
  final String adminId;
  @override
  @JsonKey()
  final String adminName;
  @override
  @JsonKey()
  final String adminImage;
//group category
  @override
  @JsonKey()
  final String category;

  @override
  String toString() {
    return 'GroupModel(id: $id, name: $name, premium: $premium, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, updatedBy: $updatedBy, description: $description, notification: $notification, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, lastMessageUserImage: $lastMessageUserImage, members: $members, onlineUsers: $onlineUsers, blockedUsers: $blockedUsers, unreadMessageUsers: $unreadMessageUsers, adminId: $adminId, adminName: $adminName, adminImage: $adminImage, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.premium, premium) || other.premium == premium) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.updatedBy, updatedBy) ||
                other.updatedBy == updatedBy) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.notification, notification) ||
                other.notification == notification) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.lastMessageUserImage, lastMessageUserImage) ||
                other.lastMessageUserImage == lastMessageUserImage) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality()
                .equals(other._onlineUsers, _onlineUsers) &&
            const DeepCollectionEquality()
                .equals(other._blockedUsers, _blockedUsers) &&
            const DeepCollectionEquality()
                .equals(other._unreadMessageUsers, _unreadMessageUsers) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            (identical(other.adminName, adminName) ||
                other.adminName == adminName) &&
            (identical(other.adminImage, adminImage) ||
                other.adminImage == adminImage) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        premium,
        imageUrl,
        createdAt,
        updatedAt,
        createdBy,
        updatedBy,
        description,
        notification,
        lastMessage,
        lastMessageTime,
        lastMessageUserImage,
        const DeepCollectionEquality().hash(_members),
        const DeepCollectionEquality().hash(_onlineUsers),
        const DeepCollectionEquality().hash(_blockedUsers),
        const DeepCollectionEquality().hash(_unreadMessageUsers),
        adminId,
        adminName,
        adminImage,
        category
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      __$$GroupModelImplCopyWithImpl<_$GroupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupModelImplToJson(
      this,
    );
  }
}

abstract class _GroupModel implements GroupModel {
  const factory _GroupModel(
      {final String id,
      final String name,
      final bool premium,
      final String imageUrl,
      final String createdAt,
      final String updatedAt,
      final String createdBy,
      final String updatedBy,
      final String description,
      final bool notification,
      final String lastMessage,
      final String lastMessageTime,
      final String lastMessageUserImage,
      final List<String> members,
      final List<String> onlineUsers,
      final List<String> blockedUsers,
      final List<String> unreadMessageUsers,
      final String adminId,
      final String adminName,
      final String adminImage,
      final String category}) = _$GroupModelImpl;

  factory _GroupModel.fromJson(Map<String, dynamic> json) =
      _$GroupModelImpl.fromJson;

  @override // group data
  String get id;
  @override
  String get name;
  @override
  bool get premium;
  @override
  String get imageUrl;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  String get createdBy;
  @override
  String get updatedBy;
  @override
  String get description;
  @override
  bool get notification;
  @override
  String get lastMessage;
  @override
  String get lastMessageTime;
  @override
  String get lastMessageUserImage;
  @override
  List<String> get members;
  @override
  List<String> get onlineUsers;
  @override
  List<String> get blockedUsers;
  @override
  List<String> get unreadMessageUsers;
  @override // group admin data
  String get adminId;
  @override
  String get adminName;
  @override
  String get adminImage;
  @override //group category
  String get category;
  @override
  @JsonKey(ignore: true)
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
