import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<InstaUser> getUserDetail() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _fireStore.collection('users').doc(currentUser.uid).get();

    return InstaUser.fromSnap(snap);
  }

  //Sign up the user
  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String response = 'An error occured, could not sign up';
    try {
      if (email.isNotEmpty ||
          username.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register the user
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //get the user profile pic download url
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        //add user to database
        InstaUser instaUser = InstaUser(
            bio: bio,
            email: email,
            followers: [],
            following: [],
            photoUrl: photoUrl,
            uid: credentials.user!.uid,
            username: username);

        await _fireStore
            .collection('users')
            .doc(credentials.user!.uid)
            .set(instaUser.toJson());
        response = 'Success!';
      }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String response = "Some error occurred.";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        response = 'success';
      } else {
        response = 'Please enter all the fields';
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
