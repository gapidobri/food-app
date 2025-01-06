import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/api/pocket_base_provider.dart';
import 'package:food_app/api/connectivity.dart';
import 'package:food_app/restaurants/models/meal.dart';
import 'package:hive_ce/hive.dart';
import 'package:pocketbase/pocketbase.dart';

final mealsRepositoryProvider = Provider<MealsRepository>((ref) {
  return MealsRepository(pocketBase: ref.read(pocketBaseProvider).requireValue);
});

class MealsRepository {
  const MealsRepository({
    required PocketBase pocketBase,
  }) : _pb = pocketBase;

  final PocketBase _pb;

  Future<List<Meal>> getMeals(String restaurantId) async {
    final mealsBox = Hive.box<List>('meals');

    if (!await isConnected()) {
      return mealsBox.get(restaurantId)?.cast<Meal>() ?? [];
    }

    final meals = await _pb
        .collection('meals')
        .getFullList(filter: 'restaurant="$restaurantId"')
        .then(
          (m) => m
              .map(
                (m) => Meal.fromJson(
                  m.data
                    ..['image'] =
                        _pb.files.getUrl(m, m.data['image']).toString(),
                ),
              )
              .toList(),
        );

    await mealsBox.put(restaurantId, meals);

    return meals;
  }
}
