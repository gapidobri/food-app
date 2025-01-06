import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/api/pocket_base_provider.dart';
import 'package:food_app/api/connectivity.dart';
import 'package:food_app/orders/models/create_order.dart';
import 'package:food_app/orders/models/order.dart';
import 'package:hive_ce/hive.dart';
import 'package:pocketbase/pocketbase.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(
    pocketBase: ref.read(pocketBaseProvider).requireValue,
    ordersBox: Hive.box('orders'),
  );
});

class OrderRepository {
  const OrderRepository({
    required PocketBase pocketBase,
    required Box<Order> ordersBox,
  })  : _pb = pocketBase,
        _box = ordersBox;

  final PocketBase _pb;
  final Box<Order> _box;

  Future<void> createOrder(CreateOrder order) async {
    await _pb.collection('orders').create(body: order.toJson());
  }

  Future<List<Order>> getOrders() async {
    if (!await isConnected()) {
      return _box.values.toList();
    }

    final orders = await _pb
        .collection('orders')
        .getFullList(expand: 'meals,restaurant')
        .then(
          (orders) => orders.map((order) {
            final json = order.data;
            json['meals'] = json['expand']['meals'];
            json['restaurant'] = json['expand']['restaurant'];
            return Order.fromJson(json);
          }).toList(),
        );

    await _box.clear();
    await _box.addAll(orders);

    return orders;
  }

  Future<void> deleteOrder(String orderId) async {
    await _pb.collection('orders').delete(orderId);
  }
}
