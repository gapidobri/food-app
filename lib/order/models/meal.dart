import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  final String id;
  final String restaurant;
  final String name;
  final String image;
  final double price;

  const Meal({
    required this.id,
    required this.restaurant,
    required this.name,
    required this.image,
    required this.price,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
