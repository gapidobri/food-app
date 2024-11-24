import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/order/models/restaurant.dart';

final restaurantProvider = Provider.family<Restaurant, String>(
  (ref, restaurantId) => const Restaurant(
    id: 'mcdonalds',
    name: "McDonald's",
    image: 'https://images.unsplash.com/photo-1602192103201-d763907bc41b?w=300',
  ),
);
