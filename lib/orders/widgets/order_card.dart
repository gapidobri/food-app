import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/orders/models/order.dart';
import 'package:food_app/orders/providers/orders_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderCard extends ConsumerWidget {
  const OrderCard({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('d. M. yyyy, HH:mm');

    void showDeleteConfirmDialog() {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
              bottom: 8.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure you want to delete this order?',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(ordersProvider.notifier).deleteOrder(order.id);
                        context.pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onLongPress: showDeleteConfirmDialog,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.restaurant.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(dateFormat.format(order.created)),
                ],
              ),
              const SizedBox(height: 8.0),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8.0,
                children: [
                  for (final meal in order.meals)
                    Chip(
                      label: Text(meal.name),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
