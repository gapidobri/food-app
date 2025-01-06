import 'package:food_app/api/pocket_base_provider.dart';
import 'package:food_app/auth/models/user.dart';
import 'package:food_app/auth/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  User? build() {
    final pb = ref.read(pocketBaseProvider);

    final userRecord = pb.value?.authStore.record;
    if (userRecord != null) {
      return User.fromJson(userRecord.data);
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    final userRepo = ref.read(userRepositoryProvider);
    final user = await userRepo.login(email, password);
    state = user;
  }

  void logout() async {
    final userRepo = ref.read(userRepositoryProvider);
    userRepo.logout();
    state = null;
  }
}
