import 'package:fire_social_media/features/profile/domain/profile_user.dart';

abstract class SearchRepo {
  Future<List<ProfileUser>> searchUsers(String query);
}
