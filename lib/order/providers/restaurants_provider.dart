import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/order/models/restaurant.dart';

final restaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  return const [
    Restaurant(
      id: 'mcdonalds',
      name: "McDonald's",
      image: 'https://images.unsplash.com/photo-1602192103201-d763907bc41b',
    ),
    Restaurant(
      id: 'beerpub',
      name: "Beer Pub",
      image: 'https://images.unsplash.com/photo-1602192103201-d763907bc41b',
    ),
    Restaurant(
      id: 'chutys',
      name: "Chuty's",
      image: 'https://images.unsplash.com/photo-1602192103201-d763907bc41b',
    ),
  ];
});
