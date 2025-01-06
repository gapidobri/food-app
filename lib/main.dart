import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/app.dart';
import 'package:food_app/hive/hive_registrar.g.dart';
import 'package:food_app/orders/models/order.dart';
import 'package:food_app/restaurants/models/restaurant.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapters();
  await Future.wait([
    Hive.openBox<Restaurant>('restaurants'),
    Hive.openBox<List>('meals'),
    Hive.openBox<Order>('orders'),
  ]);

  runApp(const ProviderScope(child: App()));
}
