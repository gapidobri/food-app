import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/orders/providers/orders_provider.dart';
import 'package:food_app/orders/widgets/order_card.dart';
import 'package:food_app/orders/models/order.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Orders',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(ordersProvider.future),
                child: switch (orders) {
                  AsyncData<List<Order>>(value: final orders) =>
                    ListView.separated(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: orders.length,
                      itemBuilder: (context, i) => OrderCard(order: orders[i]),
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 8.0),
                    ),
                  AsyncError(:final error) =>
                    Text('Failed to load orders: $error'),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
