import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/api/api.dart';
import 'package:food_app/order/models/meal.dart';
import 'package:pocketbase/pocketbase.dart';

final mealsRepositoryProvider = Provider<MealsRepository>((ref) {
  return MealsRepository(pocketBase: ref.read(pocketBaseProvider));
});

class MealsRepository {
  const MealsRepository({
    required PocketBase pocketBase,
  }) : _pb = pocketBase;

  final PocketBase _pb;

  Future<List<Meal>> getMeals(String restaurantId) {
    return _pb
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
  }
}
