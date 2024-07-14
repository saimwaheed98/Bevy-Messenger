// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserCardModelImpl _$$UserCardModelImplFromJson(Map<String, dynamic> json) =>
    _$UserCardModelImpl(
      cardNumber: json['cardNumber'] as String? ?? "",
      cardExp: json['cardExp'] as String? ?? "",
      cardCVC: json['cardCVC'] as String? ?? "",
    );

Map<String, dynamic> _$$UserCardModelImplToJson(_$UserCardModelImpl instance) =>
    <String, dynamic>{
      'cardNumber': instance.cardNumber,
      'cardExp': instance.cardExp,
      'cardCVC': instance.cardCVC,
    };
