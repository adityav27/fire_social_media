import 'package:fire_social_media/features/auth/data/firebase_auth.dart';
import 'package:fire_social_media/features/auth/screen/cubits/auth_cubit.dart';
import 'package:fire_social_media/features/auth/screen/cubits/auth_state.dart';
import 'package:fire_social_media/features/auth/screen/pages/auth_page.dart';
import 'package:fire_social_media/home_page.dart';
import 'package:fire_social_media/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  // auth repo
  final authRepo = FirebaseAuthRepo();
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        theme: lightMode,
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);
            if (authState is Authenticated) {
              return const HomePage();
            }
            if (authState is Unauthenticated) {
              return const AuthPage();
            } else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
