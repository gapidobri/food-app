import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/config.dart';
import 'package:pocketbase/pocketbase.dart';

final pocketBaseProvider = Provider<PocketBase>((ref) {
  return PocketBase(ref.read(configProvider).apiUrl);
});
