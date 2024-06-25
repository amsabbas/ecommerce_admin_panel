import 'package:json_annotation/json_annotation.dart';

part 'dashboard_data_model.g.dart';

@JsonSerializable()
class DashboardDataModel {
  @JsonKey(name: "totalUsers")
  final int totalUsers;
  @JsonKey(name: "totalOrders")
  final int totalOrders;
  @JsonKey(name: "todayOrders")
  final int todayOrders;

  DashboardDataModel({
    required this.totalUsers,
    required this.totalOrders,
    required this.todayOrders,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataModelToJson(this);
}
