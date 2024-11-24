import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/order/providers/meals_provider.dart';
import 'package:food_app/order/widgets/meal_card.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({
    super.key,
    required this.restaurantId,
  });

  final String restaurantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(mealsProvider.call(restaurantId));

    return switch (meals) {
      AsyncData(value: final meals) => GridView.builder(
          itemCount: meals.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) => MealCard(meal: meals[index]),
        ),
      AsyncError() => const Center(
          child: Text('Failed to load meals'),
        ),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}
