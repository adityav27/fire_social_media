/* Builds combined logic using states by emitting them at right time
  further these emitted states updates UI.
  States use Repo(method) to do so
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_social_media/features/auth/domain/app_user.dart';
import 'package:fire_social_media/features/auth/domain/auth_repo.dart';
import 'package:fire_social_media/features/auth/screen/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  //check if user is already Authenticated
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUserMethod();
    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  //Logout
  /* first we call out the method of repo then emit state */
  Future<void> logout() async {
    authRepo.logoutMethod();
    emit(Unauthenticated());
  }

  //get current user
  AppUser? get currentUser => _currentUser;

  //login with email and password
  Future<void> login(String email, String pw) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginMethod(email, pw);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //register iwth email,password and name
  Future<void> register(String email, String name, String pw) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.registerMethod(email, name, pw);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }
}
