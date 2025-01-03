import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      fixedColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey.shade600,
      onTap: navigationShell.goBranch,
      currentIndex: navigationShell.currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.burger),
          label: 'Restaurants',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.solidMap),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.cartShopping),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.solidUser),
          label: 'Profile',
        ),
      ],
    );
  }
}
