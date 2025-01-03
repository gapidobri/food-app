import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/api/api.dart';
import 'package:food_app/auth/models/user.dart';
import 'package:pocketbase/pocketbase.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(
    pocketBase: ref.read(pocketBaseProvider).requireValue,
  );
});

class UserRepository {
  const UserRepository({
    required PocketBase pocketBase,
  }) : _pb = pocketBase;

  final PocketBase _pb;

  User? getAuthenticatedUser() {
    final userData = _pb.authStore.record?.data;
    if (userData == null) {
      return null;
    }
    return User.fromJson(userData);
  }

  Future<User> login(String email, String password) async {
    final res = await _pb.collection('users').authWithPassword(email, password);
    return User.fromJson(res.record.data);
  }

  void logout() {
    _pb.authStore.clear();
  }
}
