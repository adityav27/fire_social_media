import 'package:fire_social_media/features/profile/domain/profile_user.dart';
import 'package:fire_social_media/features/search/domain/firebase_search_repo.dart';
import 'package:fire_social_media/features/search/screen/cubits/search_cubit.dart';
import 'package:fire_social_media/features/search/screen/cubits/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(searchRepo: FirebaseSearchRepo()),
      child: const _ExploreView(),
    );
  }
}

class _ExploreView extends StatefulWidget {
  const _ExploreView();

  @override
  State<_ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<_ExploreView> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Search box ────────────────────────────────────────────────
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search users…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          context.read<SearchCubit>().searchUsers('');
                          setState(() {}); // refresh suffixIcon
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                context.read<SearchCubit>().searchUsers(value.trim());
                setState(() {}); // update clear‑icon visibility
              },
            ),
            const SizedBox(height: 16),

            // ── Results / states ─────────────────────────────────────────
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const Center(child: Text('Type to search'));
                  }
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is SearchLoaded) {
                    final users = state.users
                        .whereType<
                          ProfileUser
                        >() // safeguard if list contains nulls
                        .toList();

                    if (users.isEmpty) {
                      return const Center(child: Text('No users found'));
                    }

                    return ListView.separated(
                      itemCount: users.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          onTap: () {
                            // TODO: navigate to user profile page
                          },
                        );
                      },
                    );
                  }
                  // Fallback (shouldn't hit)
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
