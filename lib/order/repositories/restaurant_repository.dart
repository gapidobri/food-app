import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/api/api.dart';
import 'package:food_app/order/models/restaurant.dart';
import 'package:pocketbase/pocketbase.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  return RestaurantRepository(pocketBase: ref.read(pocketBaseProvider));
});

class RestaurantRepository {
  const RestaurantRepository({
    required PocketBase pocketBase,
  }) : _pb = pocketBase;

  final PocketBase _pb;

  Future<List<Restaurant>> getRestaurants() {
    return _pb.collection('restaurants').getFullList().then((r) => r
        .map(
          (r) => Restaurant.fromJson(
            r.data..['image'] = _pb.files.getUrl(r, r.data['image']).toString(),
          ),
        )
        .toList());
  }
}
