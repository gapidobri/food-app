import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal extends HiveObject {
  final String id;
  @JsonKey(name: 'restaurant')
  final String restaurantId;
  final String name;
  final String image;
  final double price;

  Meal({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
