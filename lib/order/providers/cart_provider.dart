import 'package:food_app/order/models/meal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
class Cart extends _$Cart {
  @override
  List<Meal> build() {
    return [];
  }

  void toggleMeal(Meal meal) {
    if (state.contains(meal)) {
      removeMeal(meal);
    } else {
      addMeal(meal);
    }
  }

  void addMeal(Meal meal) {
    state = [...state, meal];
  }

  void removeMeal(Meal meal) {
    state = state.where((m) => m.id != meal.id).toList();
  }
}
