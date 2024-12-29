import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/order/models/meal.dart';
import 'package:food_app/order/repositories/meals_repository.dart';

final mealsProvider = FutureProvider.family<List<Meal>, String>(
  (ref, restaurantId) async =>
      ref.read(mealsRepositoryProvider).getMeals(restaurantId),
);
