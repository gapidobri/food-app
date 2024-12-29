import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/order/models/meal.dart';

class MealCard extends ConsumerWidget {
  const MealCard({
    super.key,
    required this.meal,
    this.selected = false,
    this.onTap,
  });

  final Meal meal;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(meal.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              color: selected ? Colors.amber.shade200 : Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('${meal.price.toStringAsFixed(2)} €'),
                    ],
                  ),
                  const Spacer(),
                  if (selected)
                    const Icon(
                      FontAwesomeIcons.check,
                      size: 16.0,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
