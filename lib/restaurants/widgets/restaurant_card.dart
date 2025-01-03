import 'package:flutter/material.dart';
import 'package:flutter_map_math/flutter_geo_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/map/providers/location_provider.dart';
import 'package:food_app/restaurants/models/restaurant.dart';
import 'package:go_router/go_router.dart';

class RestaurantCard extends ConsumerWidget {
  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);

    final distance = location.mapOrNull(
      data: (location) => FlutterMapMath().distanceBetween(
        restaurant.lat,
        restaurant.lng,
        location.value.latitude,
        location.value.longitude,
        "meters",
      ),
    );

    return Card(
      child: GestureDetector(
        onTap: () => context.push('/restaurants/${restaurant.id}'),
        child: Hero(
          tag: restaurant.id,
          child: Container(
            clipBehavior: Clip.antiAlias,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: NetworkImage(restaurant.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      const Spacer(),
                      if (distance != null) ...[
                        const Icon(
                          FontAwesomeIcons.arrowsLeftRight,
                          size: 16.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text('${distance.toInt()} m'),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
