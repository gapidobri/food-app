import 'package:json_annotation/json_annotation.dart';

part 'create_order.g.dart';

@JsonSerializable()
class CreateOrder {
  @JsonKey(name: 'user')
  final String userId;
  @JsonKey(name: 'meals')
  final List<String> mealIds;
  @JsonKey(name: 'restaurant')
  final String restaurantId;

  const CreateOrder({
    required this.userId,
    required this.mealIds,
    required this.restaurantId,
  });

  factory CreateOrder.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderToJson(this);
}
