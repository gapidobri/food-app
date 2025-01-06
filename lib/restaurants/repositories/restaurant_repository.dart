import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/api/pocket_base_provider.dart';
import 'package:food_app/api/connectivity.dart';
import 'package:food_app/restaurants/models/restaurant.dart';
import 'package:hive_ce/hive.dart';
import 'package:pocketbase/pocketbase.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  return RestaurantRepository(
    pocketBase: ref.read(pocketBaseProvider).requireValue,
  );
});

class RestaurantRepository {
  const RestaurantRepository({
    required PocketBase pocketBase,
  }) : _pb = pocketBase;

  final PocketBase _pb;

  Future<List<Restaurant>> getRestaurants() async {
    final restaurantBox = Hive.box<Restaurant>('restaurants');

    if (!await isConnected()) {
      return restaurantBox.values.toList();
    }

    final restaurants =
        await _pb.collection('restaurants').getFullList().then((r) => r
            .map(
              (r) => Restaurant.fromJson(
                r.data
                  ..['image'] = _pb.files.getUrl(r, r.data['image']).toString(),
              ),
            )
            .toList());

    await restaurantBox.clear();
    await restaurantBox.addAll(restaurants);

    return restaurants;
  }
}
