// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoModel _$PromoModelFromJson(Map<String, dynamic> json) => PromoModel(
      id: (json['id'] as num?)?.toInt(),
      isAvailable: json['is_available'] as bool?,
      discount: (json['discount_value'] as num?)?.toDouble(),
      code: json['promo_code'] as String?,
    );

Map<String, dynamic> _$PromoModelToJson(PromoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_available': instance.isAvailable,
      'discount_value': instance.discount,
      'promo_code': instance.code,
    };
