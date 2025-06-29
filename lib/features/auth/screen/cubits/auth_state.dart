// all possible states of the app.
// bloc manages state and change in state updates UI
import 'package:fire_social_media/features/auth/domain/app_user.dart';

abstract class AuthState {}

//intial  state
class AuthInitial extends AuthState {}

//loading
class AuthLoading extends AuthState {}

//authenticated
class Authenticated extends AuthState {
  final AppUser user;
  Authenticated(this.user);
}

//unauthenticated
class Unauthenticated extends AuthState {}

//errors
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
