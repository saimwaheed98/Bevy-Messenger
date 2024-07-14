// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionModelImpl _$$SubscriptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionModelImpl(
      userId: json['userId'] as String? ?? "",
      endingData: json['endingData'] as String? ?? "",
      subscribedData: json['subscribedData'] as String? ?? "",
      subscriptionId: json['subscriptionId'] as String? ?? "",
      subscribedGroupId: json['subscribedGroupId'] as String? ?? "",
      subscribedGroupName: json['subscribedGroupName'] as String? ?? "",
      subscriptionStatus: json['subscriptionStatus'] as bool? ?? true,
    );

Map<String, dynamic> _$$SubscriptionModelImplToJson(
        _$SubscriptionModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'endingData': instance.endingData,
      'subscribedData': instance.subscribedData,
      'subscriptionId': instance.subscriptionId,
      'subscribedGroupId': instance.subscribedGroupId,
      'subscribedGroupName': instance.subscribedGroupName,
      'subscriptionStatus': instance.subscriptionStatus,
    };
