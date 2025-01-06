import 'package:food_app/restaurants/models/meal.dart';
import 'package:food_app/restaurants/models/restaurant.dart';
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends HiveObject {
  final String id;
  @JsonKey(name: 'user')
  final String userId;
  final List<Meal> meals;
  final Restaurant restaurant;
  final DateTime created;
  final DateTime updated;

  Order({
    required this.id,
    required this.userId,
    required this.meals,
    required this.restaurant,
    required this.created,
    required this.updated,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
