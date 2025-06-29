import 'package:fire_social_media/components/bio_box.dart';
import 'package:fire_social_media/components/my_drawer.dart';
import 'package:fire_social_media/features/auth/domain/app_user.dart';
import 'package:fire_social_media/features/auth/screen/cubits/auth_cubit.dart';
import 'package:fire_social_media/profile/page/edit_profile_page.dart';
import 'package:fire_social_media/profile/page/profile_cubit.dart';
import 'package:fire_social_media/profile/page/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // cubits
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();
  // current user
  late AppUser? currentUser = authCubit.currentUser;

  // on startup,
  @override
  void initState() {
    super.initState();
    // load user profile data
    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        //loaded state
        if (state is ProfileLoaded) {
          // get loaded user
          final user = state.profileUser;

          //Scaffold
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
              ),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(
                user.name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              actions: [
                // edit profile button
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(user: user),
                    ),
                  ),
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
            drawer: MyDrawer(),

            body: Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  //Profile Photo
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 200,
                    width: 200,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Bio",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 15),
                  BioBox(message: user.bio),
                  SizedBox(height: 20),
                  Text(
                    "Post",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        //loading
        else if (state is ProfileLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        //last case no profile
        else {
          return Scaffold(
            body: Center(child: Text("N O   P R O F I L E   F O U N D")),
          );
        }
      },
    );
  }
}
