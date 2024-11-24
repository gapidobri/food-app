import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/order/providers/restaurants_provider.dart';
import 'package:food_app/order/widgets/restaurant_card.dart';

class RestaurantListScreen extends ConsumerWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurants = ref.watch(restaurantsProvider);

    return switch (restaurants) {
      AsyncData(value: final restaurants) => ListView.separated(
          itemCount: restaurants.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RestaurantCard(
              restaurant: restaurants[index],
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 8.0),
        ),
      AsyncError() => const Center(
          child: Text('Failed to load restaurants'),
        ),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}
