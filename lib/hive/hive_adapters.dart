import 'package:food_app/orders/models/order.dart';
import 'package:food_app/restaurants/models/meal.dart';
import 'package:food_app/restaurants/models/restaurant.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([
  AdapterSpec<Restaurant>(),
  AdapterSpec<Meal>(),
  AdapterSpec<Order>(),
])
void _() {}
