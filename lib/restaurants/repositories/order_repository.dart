import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/api/api.dart';
import 'package:food_app/restaurants/models/order.dart';
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

  Future<void> createOrder(Order order) {
    return _pb.collection('orders').create(body: order.toJson());
  }
}
