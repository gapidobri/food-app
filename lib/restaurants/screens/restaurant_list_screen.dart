import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/restaurants/providers/restaurants_provider.dart';
import 'package:food_app/restaurants/widgets/restaurant_card.dart';

class RestaurantListScreen extends ConsumerWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurants = ref.watch(restaurantsProvider);

    return RefreshIndicator(
      edgeOffset: 16.0,
      onRefresh: () => ref.refresh(restaurantsProvider.future),
      child: switch (restaurants) {
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
        AsyncError(error: final error) => Center(
            child: Text('Failed to load restaurants: $error'),
          ),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
