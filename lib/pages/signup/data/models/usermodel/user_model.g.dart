// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      isOnline: json['isOnline'] as bool? ?? true,
      address: json['address'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      password: json['password'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      pushToken: json['pushToken'] as String? ?? '',
      subscription: json['subscription'] as bool? ?? false,
      lastActive: json['lastActive'] as String? ?? '',
      city: json['city'] as String? ?? '',
      country: json['country'] as String? ?? '',
      state: json['state'] as String? ?? '',
      userInternetState: json['userInternetState'] as bool? ?? false,
      blockedUsers: json['blockedUsers'] as List<dynamic>? ?? const [],
      blockedBy: json['blockedBy'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'isOnline': instance.isOnline,
      'address': instance.address,
      'imageUrl': instance.imageUrl,
      'password': instance.password,
      'createdAt': instance.createdAt,
      'pushToken': instance.pushToken,
      'subscription': instance.subscription,
      'lastActive': instance.lastActive,
      'city': instance.city,
      'country': instance.country,
      'state': instance.state,
      'userInternetState': instance.userInternetState,
      'blockedUsers': instance.blockedUsers,
      'blockedBy': instance.blockedBy,
    };
