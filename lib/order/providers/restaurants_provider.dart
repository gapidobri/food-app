import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/order/models/restaurant.dart';
import 'package:food_app/order/repositories/restaurant_repository.dart';

final restaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  return ref.read(restaurantRepositoryProvider).getRestaurants();
});
