import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    if (user == null) {
      return const SizedBox();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 48.0,
          child: Icon(
            FontAwesomeIcons.user,
            size: 42.0,
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(user.email),
        const SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: () => ref.read(authProvider.notifier).logout(),
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
