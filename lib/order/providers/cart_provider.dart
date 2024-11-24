import 'package:food_app/order/models/meal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
class Cart extends _$Cart {
  @override
  Map<Meal, int> build() {
    return {};
  }

  void addMeal(Meal meal) {
    state = {...state, meal: state[meal] ?? 0 + 1};
  }

  void removeMeal(Meal meal) {
    if (!state.containsKey(meal)) return;

    if (state[meal] == 1) {
      state.remove(meal);
      state = {...state};
    } else {
      state = {...state, meal: (state[meal] ?? 0) - 1};
    }
  }
}
