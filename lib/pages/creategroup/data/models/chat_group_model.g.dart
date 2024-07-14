// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupModelImpl _$$GroupModelImplFromJson(Map<String, dynamic> json) =>
    _$GroupModelImpl(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      premium: json['premium'] as bool? ?? true,
      imageUrl: json['imageUrl'] as String? ?? "",
      createdAt: json['createdAt'] as String? ?? "",
      updatedAt: json['updatedAt'] as String? ?? "",
      createdBy: json['createdBy'] as String? ?? "",
      updatedBy: json['updatedBy'] as String? ?? "",
      description: json['description'] as String? ?? "",
      notification: json['notification'] as bool? ?? true,
      lastMessage: json['lastMessage'] as String? ?? "",
      lastMessageTime: json['lastMessageTime'] as String? ?? "",
      lastMessageUserImage: json['lastMessageUserImage'] as String? ?? "",
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      onlineUsers: (json['onlineUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      blockedUsers: (json['blockedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      unreadMessageUsers: (json['unreadMessageUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      adminId: json['adminId'] as String? ?? "",
      adminName: json['adminName'] as String? ?? "",
      adminImage: json['adminImage'] as String? ?? "",
      category: json['category'] as String? ?? "",
    );

Map<String, dynamic> _$$GroupModelImplToJson(_$GroupModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'premium': instance.premium,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'description': instance.description,
      'notification': instance.notification,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'lastMessageUserImage': instance.lastMessageUserImage,
      'members': instance.members,
      'onlineUsers': instance.onlineUsers,
      'blockedUsers': instance.blockedUsers,
      'unreadMessageUsers': instance.unreadMessageUsers,
      'adminId': instance.adminId,
      'adminName': instance.adminName,
      'adminImage': instance.adminImage,
      'category': instance.category,
    };
