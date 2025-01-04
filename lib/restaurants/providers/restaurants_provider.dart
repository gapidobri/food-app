import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/map/providers/location_provider.dart';
import 'package:food_app/restaurants/models/restaurant.dart';
import 'package:food_app/restaurants/repositories/restaurant_repository.dart';
import 'package:latlong2/latlong.dart';

final restaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  final restaurants =
      await ref.read(restaurantRepositoryProvider).getRestaurants();

  final location = ref.read(locationProvider);
  if (location is AsyncData<LatLng>) {
    final mapMath = FlutterMapMath();
    restaurants.sort(
      (r1, r2) =>
          mapMath
              .distanceBetween(
                r1.lat,
                r1.lng,
                location.value.latitude,
                location.value.longitude,
                "meters",
              )
              .toInt() -
          mapMath
              .distanceBetween(
                r2.lat,
                r2.lng,
                location.value.latitude,
                location.value.longitude,
                "meters",
              )
              .toInt(),
    );
  }

  return restaurants;
});
