import 'package:food_app/orders/models/order.dart';
import 'package:food_app/orders/repositories/order_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'orders_provider.g.dart';

@riverpod
class Orders extends _$Orders {
  @override
  Future<List<Order>> build() async {
    final orders = await ref.read(orderRepositoryProvider).getOrders();
    orders.sort((a, b) => b.created.compareTo(a.created));
    return orders;
  }

  Future<void> deleteOrder(String orderId) async {
    await ref.read(orderRepositoryProvider).deleteOrder(orderId);
    state = state.whenData(
        (orders) => orders.where((order) => order.id != orderId).toList());
  }
}
