import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/order/models/restaurant.dart';
import 'package:food_app/order/providers/restaurants_provider.dart';

final restaurantProvider = FutureProvider.family<Restaurant, String>(
  (ref, restaurantId) async => ref
      .watch(restaurantsProvider.future)
      .then((r) => r.firstWhere((r) => r.id == restaurantId)),
);
