import 'package:flutter/material.dart';
import 'package:food_app/map/map_screen.dart';
import 'package:food_app/order/screens/restaurant_screen.dart';
import 'package:food_app/order/screens/restaurant_list_screen.dart';
import 'package:food_app/profile/profile_screen.dart';
import 'package:food_app/bottom_navigation/bottom_navigation.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/restaurants',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => Scaffold(
        body: navigationShell,
        bottomNavigationBar: BottomNavigation(
          navigationShell: navigationShell,
        ),
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/restaurants',
              builder: (context, state) => const RestaurantListScreen(),
              routes: [
                GoRoute(
                  path: ':restaurantId',
                  builder: (context, state) => RestaurantScreen(
                    restaurantId: state.pathParameters['restaurantId']!,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/map',
              builder: (context, state) => const MapScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
