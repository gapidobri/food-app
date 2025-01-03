import 'package:food_app/auth/providers/auth_provider.dart';
import 'package:food_app/restaurants/models/meal.dart';
import 'package:food_app/restaurants/models/order.dart';
import 'package:food_app/restaurants/repositories/order_repository.dart';
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

  Future<void> order() async {
    final user = ref.read(authProvider);
    if (user == null) return;

    final orderRepo = ref.read(orderRepositoryProvider);

    final mealIds = state.map((meal) => meal.id).toList();

    await orderRepo.createOrder(
      Order(
        userId: user.id,
        mealIds: mealIds,
      ),
    );

    state = [];
  }
}
