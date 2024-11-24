import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/order/models/meal.dart';

final mealsProvider = FutureProvider.family<List<Meal>, String>(
  (ref, restaurantId) async {
    return [
      const Meal(
        id: 'bigmac',
        restaurantId: 'mcdonalds',
        name: 'Big Mac',
        image: 'https://images.unsplash.com/photo-1602192103201-d763907bc41b',
        price: 5.95,
      ),
    ];
  },
);
