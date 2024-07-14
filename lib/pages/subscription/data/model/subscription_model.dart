import 'package:freezed_annotation/freezed_annotation.dart';
part "subscription_model.freezed.dart";
part "subscription_model.g.dart";

@Freezed()
class SubscriptionModel with _$SubscriptionModel {
  const factory SubscriptionModel({
    @Default("") String userId,
    @Default("") String endingData,
    @Default("") String subscribedData,
    @Default("") String subscriptionId,
    @Default("") String subscribedGroupId,
    @Default("") String subscribedGroupName,
    @Default(true) bool subscriptionStatus,
  }) = _SubscriptionModel;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);
}
