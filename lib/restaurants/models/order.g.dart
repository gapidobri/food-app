// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      userId: json['user'] as String,
      mealIds:
          (json['meals'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'user': instance.userId,
      'meals': instance.mealIds,
    };
