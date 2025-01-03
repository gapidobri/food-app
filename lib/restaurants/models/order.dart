import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'user')
  final String userId;
  @JsonKey(name: 'meals')
  final List<String> mealIds;

  const Order({required this.userId, required this.mealIds});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
