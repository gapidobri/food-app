import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/config.dart';
import 'package:pocketbase/pocketbase.dart';

final pocketBaseProvider = FutureProvider<PocketBase>((ref) async {
  const secureStorage = FlutterSecureStorage();

  final pb = PocketBase(
    ref.read(configProvider).apiUrl,
    authStore: AsyncAuthStore(
      initial: await secureStorage.read(key: 'pb_auth'),
      save: (data) => secureStorage.write(key: 'pb_auth', value: data),
      clear: () => secureStorage.delete(key: 'pb_auth'),
    ),
  );

  return pb;
});
