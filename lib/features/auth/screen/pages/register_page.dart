import 'package:fire_social_media/components/my_logobutton.dart';
import 'package:fire_social_media/components/my_textfield.dart';
import 'package:fire_social_media/features/auth/screen/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;
  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //register button
    void register() {
      // prepare info
      final String email = emailController.text.trim();
      final String name = nameController.text.trim();
      final String pw = pwController.text.trim();
      final String confirmPw = confirmPwController.text.trim();

      // auth cubit
      final authCubit = context.read<AuthCubit>();
      // ensure the fields aren't empty
      if (email.isNotEmpty &&
          name.isNotEmpty &&
          pw.isNotEmpty &&
          confirmPw.isNotEmpty) {
        if (pw == confirmPw) {
          authCubit.register(email, name, pw);
        }
        // passwords don't match
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Passwords do not match!")),
          );
        }
      }
      // fields are empty → display error
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please complete all fields")),
        );
      }
    }

    @override
    void dispose() {
      nameController.dispose();
      emailController.dispose();
      pwController.dispose();
      confirmPwController.dispose();
      super.dispose();
    }

    //UI
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
                  "Welcome to the family",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),
                MyTextfield(
                  hintText: "Enter your full name",
                  obscureBool: false,
                  controller: nameController,
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
                SizedBox(height: 30),
                MyTextfield(
                  hintText: "Enter your password again",
                  obscureBool: true,
                  controller: confirmPwController,
                ),
                SizedBox(height: 30),
                MyLogobutton(
                  message: "R E G I S T E R",
                  bgColor: Theme.of(context).colorScheme.surface,
                  whatToDo: register,
                ),
                SizedBox(height: 30),
                //message for register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already have a account?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePage,
                      child: Text(
                        "Login",
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
