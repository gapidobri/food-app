import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/restaurants/providers/cart_provider.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final total = cart.fold(0.0, (sum, meal) => sum + meal.price);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              for (final meal in cart)
                Row(
                  children: [
                    Text(meal.name),
                    const Spacer(),
                    Text('${meal.price.toStringAsFixed(2)} €'),
                  ],
                ),
              const Divider(height: 32.0),
              Row(
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${total.toStringAsFixed(2)} €',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  ref.read(cartProvider.notifier).order();
                  context.pop();
                },
                child: const Text('Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
