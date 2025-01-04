import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/api/api.dart';
import 'package:food_app/orders/models/create_order.dart';
import 'package:food_app/orders/models/order.dart';
import 'package:pocketbase/pocketbase.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(
    pocketBase: ref.read(pocketBaseProvider).requireValue,
  );
});

class OrderRepository {
  const OrderRepository({
    required PocketBase pocketBase,
  }) : _pb = pocketBase;

  final PocketBase _pb;

  Future<void> createOrder(CreateOrder order) async {
    await _pb.collection('orders').create(body: order.toJson());
  }

  Future<List<Order>> getOrders() async {
    return await _pb
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
  }

  Future<void> deleteOrder(String orderId) async {
    await _pb.collection('orders').delete(orderId);
  }
}
