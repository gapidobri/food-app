import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/api/api.dart';
import 'package:food_app/routes.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pocketBase = ref.watch(pocketBaseProvider);
    if (!pocketBase.hasValue) {
      return const SizedBox();
    }

    return MaterialApp.router(
      routerConfig: ref.watch(routesProvider),
    );
  }
}
