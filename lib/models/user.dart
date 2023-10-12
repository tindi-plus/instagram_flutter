import 'package:cloud_firestore/cloud_firestore.dart';

class InstaUser {
  final String email;
  final String username;
  final String uid;
  final String photoUrl;
  final String bio;
  final List followers;
  final List following;

  const InstaUser({
    required this.bio,
    required this.email,
    required this.followers,
    required this.following,
    required this.photoUrl,
    required this.uid,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'uid': uid,
      'bio': bio,
      'followers': followers,
      'following': following,
      'photoUrl': photoUrl,
    };
  }

  static InstaUser fromSnap(DocumentSnapshot snapShot) {
    var snap = snapShot.data() as Map<String, dynamic>;

    return InstaUser(
        bio: snap['bio'],
        email: snap['email'],
        followers: snap['followers'],
        following: snap['following'],
        photoUrl: snap['photoUrl'],
        uid: snap['uid'],
        username: snap['username']);
  }
}
