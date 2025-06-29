import 'package:fire_social_media/features/auth/data/firebase_auth.dart';
import 'package:fire_social_media/features/auth/screen/cubits/auth_cubit.dart';
import 'package:fire_social_media/features/auth/screen/cubits/auth_state.dart';
import 'package:fire_social_media/features/auth/screen/pages/auth_page.dart';
import 'package:fire_social_media/manager.dart';
import 'package:fire_social_media/profile/data/firebase_profile_repo.dart';
import 'package:fire_social_media/profile/page/profile_cubit.dart';
import 'package:fire_social_media/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  // auth repo
  final authRepo = FirebaseAuthRepo();
  // profile repo
  final profileRepo = FirebaseProfileRepo();
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(profileRepo: profileRepo),
        ),
      ],
      child: MaterialApp(
        theme: lightMode,
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);
            if (authState is Authenticated) {
              return const ManagerPage();
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
