// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String,
      userId: json['user'] as String,
      meals: (json['meals'] as List<dynamic>)
          .map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList(),
      restaurant:
          Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.userId,
      'meals': instance.meals,
      'restaurant': instance.restaurant,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };
