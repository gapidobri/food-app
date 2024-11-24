import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/order/providers/meals_provider.dart';
import 'package:food_app/order/providers/restaurant_provider.dart';
import 'package:food_app/order/widgets/meal_card.dart';
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

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
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
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 32.0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16.0,
                        bottom: 16.0,
                        child: Text(
                          restaurant.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          switch (meals) {
            AsyncData(value: final meals) => SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => MealCard(meal: meals[index]),
                    childCount: meals.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                ),
              ),
            AsyncError() => const SliverToBoxAdapter(
                child: Center(
                  child: Text('Failed to load meals'),
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
    );
  }
}
