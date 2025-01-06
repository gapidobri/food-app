import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant extends HiveObject {
  final String id;
  final String name;
  final String image;
  final double lat;
  final double lng;
  @JsonKey(name: "pin_icon")
  final String? pinIcon;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.lat,
    required this.lng,
    this.pinIcon,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
