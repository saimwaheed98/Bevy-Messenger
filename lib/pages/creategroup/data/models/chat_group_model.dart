import 'package:freezed_annotation/freezed_annotation.dart';
part 'chat_group_model.freezed.dart';
part 'chat_group_model.g.dart';

@Freezed()
class GroupModel with _$GroupModel {
  const factory GroupModel({
    // group data
    @Default("") String id,
    @Default("") String name,
    @Default(true) bool premium,
    @Default("") String imageUrl,
    @Default("") String createdAt,
    @Default("") String updatedAt,
    @Default("") String createdBy,
    @Default("") String updatedBy,
    @Default("") String description,
    @Default(true) bool notification,
    @Default("") String lastMessage,
    @Default("") String lastMessageTime,
    @Default("") String lastMessageUserImage,
    @Default([]) List<String> members,
    @Default([]) List<String> onlineUsers,
    @Default([]) List<String> blockedUsers,
    @Default([]) List<String> unreadMessageUsers,
    // group admin data
    @Default("") String adminId,
    @Default("") String adminName,
    @Default("") String adminImage,
    //group category
    @Default("") String category,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);
}