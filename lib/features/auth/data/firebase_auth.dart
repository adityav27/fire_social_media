//Child class of AuthRepo
//Implements the function/logic of the methods used in AuthRepo

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_social_media/features/auth/domain/app_user.dart';
import 'package:fire_social_media/features/auth/domain/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo extends AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<AppUser?> loginMethod(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      //return user
      return user;
    } catch (e) {
      throw Exception('Login Failed: $e');
    }
  }

  @override
  Future<AppUser?> registerMethod(
    String email,
    String name,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );
      // save user data in firestore
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());
      //return user
      return user;
    } catch (e) {
      throw Exception('Sign up Failed: $e');
    }
  }

  @override
  Future<void> logoutMethod() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUserMethod() async {
    //get current user first
    final _firebaseUser = _firebaseAuth.currentUser;
    //if no current user
    if (_firebaseUser == null) {
      return null;
    }
    //extract current user info
    return AppUser(
      email: _firebaseUser.email!,
      name: '',
      uid: _firebaseUser.uid,
    );
  }
}
