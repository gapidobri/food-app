import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/restaurants/providers/cart_provider.dart';
import 'package:food_app/restaurants/providers/meals_provider.dart';
import 'package:food_app/restaurants/providers/restaurant_provider.dart';
import 'package:food_app/restaurants/widgets/meal_card.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({
    super.key,
    required this.restaurantId,
  });

  final String restaurantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurant = ref.watch(restaurantProvider.call(restaurantId));
    final meals = ref.watch(mealsProvider.call(restaurantId));
    final cart = ref.watch(cartProvider);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              switch (restaurant) {
                AsyncData(value: final restaurant) => SliverToBoxAdapter(
                    child: Hero(
                      tag: restaurant.id,
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: NetworkImage(restaurant.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SafeArea(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: () => context.pop(),
                                  icon: const Icon(
                                    FontAwesomeIcons.chevronLeft,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withAlpha(150),
                                        Colors.transparent
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        restaurant.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                _ => const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              },
              switch (meals) {
                AsyncData(value: final meals) => SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => MealCard(
                          meal: meals[index],
                          selected: cart.contains(meals[index]),
                          onTap: () => ref
                              .read(cartProvider.notifier)
                              .toggleMeal(meals[index]),
                        ),
                        childCount: meals.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                    ),
                  ),
                AsyncError(error: final error) => SliverToBoxAdapter(
                    child: Center(
                      child: Text('Failed to load meals: $error'),
                    ),
                  ),
                _ => const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              }
            ],
          ),
          if (cart.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => context.push('/cart'),
                  child: const Text('Order'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
