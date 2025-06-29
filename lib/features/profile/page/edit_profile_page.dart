import 'package:fire_social_media/components/my_textfield.dart';
import 'package:fire_social_media/features/profile/domain/profile_user.dart';
import 'package:fire_social_media/features/profile/page/profile_cubit.dart';
import 'package:fire_social_media/features/profile/page/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final bioController = TextEditingController();

  //update profile button
  void updateProfile() async {
    final text = bioController.text.trim();
    if (text.isNotEmpty) {
      await context.read<ProfileCubit>().updateProfile(
        uid: widget.user.uid,
        bio: text, // use `bio:`  ← matches cubit
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        //profile loading
        if (state is ProfileLoading) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    "Uploading",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return buildEditPage();
        }
        //profile error
        // edit form
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditPage({double uploadProgress = 0.0}) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: const Text("Edit Profile"),
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: updateProfile, icon: Icon(Icons.done)),
          ),
        ],
      ),
      body: Column(
        children: [
          //profile photo

          //Bio
          Text("Bio"),
          SizedBox(height: 15),
          MyTextfield(
            hintText: widget.user.bio,
            obscureBool: false,
            controller: bioController,
          ),
        ],
      ),
    );
  }
}
