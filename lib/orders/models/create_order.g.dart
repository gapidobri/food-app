// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrder _$CreateOrderFromJson(Map<String, dynamic> json) => CreateOrder(
      userId: json['user'] as String,
      mealIds:
          (json['meals'] as List<dynamic>).map((e) => e as String).toList(),
      restaurantId: json['restaurant'] as String,
    );

Map<String, dynamic> _$CreateOrderToJson(CreateOrder instance) =>
    <String, dynamic>{
      'user': instance.userId,
      'meals': instance.mealIds,
      'restaurant': instance.restaurantId,
    };
