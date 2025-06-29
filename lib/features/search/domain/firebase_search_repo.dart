import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_social_media/features/profile/domain/profile_user.dart';
import 'package:fire_social_media/features/search/domain/search_repo.dart';

class FirebaseSearchRepo implements SearchRepo {
  @override
  Future<List<ProfileUser>> searchUsers(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final snap = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .limit(20)
          .get();

      return snap.docs.map((doc) => ProfileUser.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Error searching users: $e');
    }
  }
}
