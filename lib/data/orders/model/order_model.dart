import 'package:ecommerce_admin/data/orders/model/order_info_model.dart';
import 'package:ecommerce_admin/data/products/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "status")
  final String status;

  @JsonKey(name: "order_date")
  final String date;

  @JsonKey(name: "subtotal")
  final double subtotal;

  @JsonKey(name: "discount")
  final double discount;

  @JsonKey(name: "total")
  final double total;
  @JsonKey(name: "deliveryFees")
  final double deliveryFees;

  @JsonKey(name: "products")
  final List<ProductModel>? products;

  @JsonKey(name: "info")
  final List<OrderInfoModel>? info;

  OrderModel({
    required this.id,
    required this.status,
    required this.date,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.deliveryFees,
    required this.products,
    required this.info,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
