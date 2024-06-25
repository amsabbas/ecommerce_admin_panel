// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardDataModel _$DashboardDataModelFromJson(Map<String, dynamic> json) =>
    DashboardDataModel(
      totalUsers: (json['totalUsers'] as num).toInt(),
      totalOrders: (json['totalOrders'] as num).toInt(),
      todayOrders: (json['todayOrders'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardDataModelToJson(DashboardDataModel instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'totalOrders': instance.totalOrders,
      'todayOrders': instance.todayOrders,
    };
