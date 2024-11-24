import 'package:food_app/order/models/meal.dart';

class Order {
  final Map<Meal, int> meals;

  const Order({
    this.meals = const {},
  });
}
