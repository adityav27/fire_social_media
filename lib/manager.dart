import 'package:fire_social_media/explore_page.dart';
import 'package:fire_social_media/features/auth/screen/cubits/auth_cubit.dart';
import 'package:fire_social_media/home_page.dart';
import 'package:fire_social_media/profile/page/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Grab the current user UID (empty string if not logged in)
    final authCubit = context.watch<AuthCubit>();
    final currentUid = authCubit.currentUser?.uid ?? '';

    // Pages to show for each tab
    final pages = [
      const HomePage(),
      const ExplorePage(),
      ProfilePage(uid: currentUid),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: _buildNavBar(),
      ),
    );
  }

  /// Bottom navigation bar builder
  Widget _buildNavBar() {
    return GNav(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      color: Theme.of(context).colorScheme.tertiary,
      activeColor: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.all(20),
      tabBackgroundColor: Theme.of(context).colorScheme.tertiary,
      gap: 8,
      selectedIndex: _selectedIndex,
      onTabChange: (index) => setState(() => _selectedIndex = index),
      tabs: const [
        GButton(icon: Icons.favorite, text: 'Favorites'),
        GButton(icon: Icons.explore, text: 'Explore'),
        GButton(icon: Icons.person, text: 'Profile'),
      ],
    );
  }
}
