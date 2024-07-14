import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_card_model.freezed.dart';
part 'user_card_model.g.dart';

@Freezed()
class UserCardModel with _$UserCardModel{
  factory UserCardModel({
    @Default("") String cardNumber,
    @Default("") String cardExp,
    @Default("") String cardCVC,
}) = _UserCardModel;

  factory UserCardModel.fromJson(Map<String,dynamic> json) => _$UserCardModelFromJson(json);
}