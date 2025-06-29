import 'package:fire_social_media/features/auth/screen/pages/login_page.dart';
import 'package:fire_social_media/features/auth/screen/pages/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show login page
  bool showLoginPage = true;

  //toggle between pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage == true) {
      return LoginPage(togglePage: togglePages);
    } else {
      return RegisterPage(togglePage: togglePages);
    }
  }
}
