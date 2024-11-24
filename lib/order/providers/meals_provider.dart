import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/order/models/meal.dart';

final mealsProvider = FutureProvider.family<List<Meal>, String>(
  (ref, restaurantId) async {
    return const [
      Meal(
        id: 'bigmac',
        restaurantId: 'mcdonalds',
        name: 'Big Mac',
        image:
            'https://images.unsplash.com/photo-1602192103201-d763907bc41b?w=300',
        price: 5.95,
      ),
      Meal(
        id: 'fries',
        restaurantId: 'mcdonalds',
        name: 'Fries',
        image:
            'https://images.unsplash.com/photo-1518013431117-eb1465fa5752?w=300',
        price: 3.5,
      ),
      Meal(
        id: 'nuggets',
        restaurantId: 'mcdonalds',
        name: 'McNuggets',
        image:
            'https://images.unsplash.com/photo-1619881589279-20f389897508?w=300',
        price: 3.5,
      ),
    ];
  },
);
