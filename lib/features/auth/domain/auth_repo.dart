import 'package:fire_social_media/features/auth/domain/app_user.dart';

abstract class AuthRepo {
  // list down all possible methods
  Future<AppUser?> loginMethod(String email, String password);
  Future<AppUser?> registerMethod(String email, String name, String password);
  Future<void> logoutMethod();
  Future<AppUser?> getCurrentUserMethod();
}
