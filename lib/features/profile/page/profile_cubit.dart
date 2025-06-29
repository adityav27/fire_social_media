import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_social_media/features/profile/domain/profile_repo.dart';
import 'package:fire_social_media/features/profile/page/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  /* ─────────────────────────── FETCH ─────────────────────────── */
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User not found'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /* ─────────────────────────── UPDATE ─────────────────────────── */
  Future<void> updateProfile({
    required String uid,
    String? bio, // NOTE: matches ProfileUser.copyWith()
  }) async {
    emit(ProfileLoading());
    try {
      // 1. current data
      final current = await profileRepo.fetchUserProfile(uid);
      if (current == null) {
        emit(ProfileError('Failed to fetch user for profile update'));
        return;
      }

      // 2. new model
      final updated = current.copyWith(bio: bio ?? current.bio);

      // 3. push to backend
      await profileRepo.updateProfile(updated);

      // 4. broadcast to listeners
      emit(ProfileLoaded(updated));
    } catch (e) {
      emit(ProfileError('Error updating profile: $e'));
    }
  }
}
