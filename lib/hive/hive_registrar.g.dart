// Generated by Hive CE
// Do not modify
// Check in to version control

import 'package:hive_ce/hive.dart';
import 'package:food_app/hive/hive_adapters.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(MealAdapter());
    registerAdapter(OrderAdapter());
    registerAdapter(RestaurantAdapter());
  }
}