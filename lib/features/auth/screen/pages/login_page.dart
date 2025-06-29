import 'package:fire_social_media/components/my_logobutton.dart';
import 'package:fire_social_media/components/my_textfield.dart';
import 'package:fire_social_media/features/auth/screen/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePage;
  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  //login function
  void login() {
    // prepare email & pw
    final String email = emailController.text;
    final String pw = pwController.text;
    // auth cubit
    final authCubit = context.read<AuthCubit>();
    // ensure that the email & pw fiels are not empty
    if (email.isNotEmpty && pw.isNotEmpty) {
      // login!
      authCubit.login(email, pw);
    }
    // display error if some fields are empty
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.face_unlock_rounded,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: 50),
                // welcome back msg
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),
                MyTextfield(
                  hintText: "Enter your email",
                  obscureBool: false,
                  controller: emailController,
                ),
                SizedBox(height: 30),
                MyTextfield(
                  hintText: "Enter your password",
                  obscureBool: true,
                  controller: pwController,
                ),
                SizedBox(height: 70),
                MyLogobutton(
                  message: "L O G I N",
                  bgColor: Theme.of(context).colorScheme.surface,
                  whatToDo: login,
                ),
                SizedBox(height: 200),
                //message for register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePage,
                      child: Text(
                        " Register now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
