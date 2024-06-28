import 'package:json_annotation/json_annotation.dart';

part 'promo_model.g.dart';

@JsonSerializable()
class PromoModel {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "is_available")
  final bool? isAvailable;
  @JsonKey(name: "discount_value")
  final double? discount;
  @JsonKey(name: "promo_code")
  final String? code;


  PromoModel({
    required this.id,
    required this.isAvailable,
    required this.discount,
    required this.code,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) =>
      _$PromoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromoModelToJson(this);
}
