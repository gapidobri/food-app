import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/map/utils/icons.dart';
import 'package:food_app/restaurants/models/restaurant.dart';
import 'package:food_app/restaurants/providers/restaurants_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late AlignOnUpdate alignPositionOnUpdate;
  late final StreamController<double?> alignPositionStreamController;

  @override
  void initState() {
    super.initState();
    alignPositionOnUpdate = AlignOnUpdate.always;
    alignPositionStreamController = StreamController<double?>();
  }

  @override
  void dispose() {
    super.dispose();
    alignPositionStreamController.close();
  }

  void alignPosition() {
    setState(
      () => alignPositionOnUpdate = AlignOnUpdate.always,
    );
    alignPositionStreamController.add(17.0);
  }

  void handlePositionChanged(MapCamera camera, bool hasGesture) {
    if (hasGesture && alignPositionOnUpdate != AlignOnUpdate.never) {
      setState(
        () => alignPositionOnUpdate = AlignOnUpdate.never,
      );
    }
  }

  void openRestaurant(String restaurantId) {
    context.go('/restaurants/$restaurantId');
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = ref.watch(restaurantsProvider);

    return FlutterMap(
      options: MapOptions(
        initialZoom: 17.0,
        onPositionChanged: handlePositionChanged,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'me.gapi.food_app',
          tileProvider: CancellableNetworkTileProvider(),
        ),
        RichAttributionWidget(
          alignment: AttributionAlignment.bottomLeft,
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(
                Uri.parse('https://openstreetmap.org/copyright'),
              ),
            ),
          ],
        ),
        CurrentLocationLayer(
          alignPositionStream: alignPositionStreamController.stream,
          alignPositionOnUpdate: alignPositionOnUpdate,
        ),
        MarkerLayer(
          markers: [
            if (restaurants is AsyncData<List<Restaurant>>)
              for (final restaurant in restaurants.value)
                Marker(
                  point: LatLng(restaurant.lat, restaurant.lng),
                  child: GestureDetector(
                    onTap: () => openRestaurant(restaurant.id),
                    child: Icon(
                      icons[restaurant.pinIcon] ?? FontAwesomeIcons.locationDot,
                    ),
                  ),
                  alignment: Alignment.topCenter,
                  rotate: true,
                ),
          ],
        ),
        Positioned(
          right: 16.0,
          bottom: 16.0,
          child: FloatingActionButton(
            onPressed: alignPosition,
            child: const Icon(FontAwesomeIcons.locationCrosshairs),
          ),
        ),
      ],
    );
  }
}
