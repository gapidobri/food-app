import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/auth/providers/auth_provider.dart';
import 'package:food_app/auth/screens/login_screen.dart';
import 'package:food_app/auth/screens/register_screen.dart';
import 'package:food_app/map/map_screen.dart';
import 'package:food_app/orders/screens/orders_screen.dart';
import 'package:food_app/profile/profile_screen.dart';
import 'package:food_app/bottom_navigation/bottom_navigation.dart';
import 'package:food_app/restaurants/screens/cart_screen.dart';
import 'package:food_app/restaurants/screens/restaurant_list_screen.dart';
import 'package:food_app/restaurants/screens/restaurant_screen.dart';
import 'package:go_router/go_router.dart';

final routesProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/restaurants',
    routes: [
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        redirect: (context, state) =>
            ref.watch(authProvider) == null ? '/login' : null,
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
            path: '/cart',
            builder: (context, state) => const CartScreen(),
          ),
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
                    path: '/orders',
                    builder: (context, state) => const OrdersScreen(),
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
      ),
    ],
  );
});
