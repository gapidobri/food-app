import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/restaurants/models/meal.dart';
import 'package:food_app/restaurants/repositories/meals_repository.dart';

final mealsProvider = FutureProvider.family<List<Meal>, String>(
  (ref, restaurantId) async =>
      ref.read(mealsRepositoryProvider).getMeals(restaurantId),
);
