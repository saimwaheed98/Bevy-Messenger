import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@Freezed()
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String email,
    @Default('') String phone,
    @Default(true) bool isOnline,
    @Default('') String address,
    @Default('') String imageUrl,
    @Default('') String password,
    @Default('') String createdAt,
    @Default('') String pushToken,
    @Default(false) bool subscription,
    @Default('') String lastActive,
    @Default('') String city,
    @Default('') String country,
    @Default('') String state,
    @Default(false) bool userInternetState,
    @Default([]) List blockedUsers,
    @Default([]) List blockedBy,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
