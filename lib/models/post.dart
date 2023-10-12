import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Post {
  final String description;
  final String username;
  final String uid;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final List likes;

  const Post(
      {required this.description,
      required this.postId,
      required this.postUrl,
      required this.likes,
      required this.profImage,
      required this.uid,
      required this.username,
      required this.datePublished});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'datePublished': datePublished,
      'uid': uid,
      'profImage': profImage,
      'postId': postId,
      'postUrl': postUrl,
      'description': description,
      'likes': likes,
    };
  }

  static Post fromSnap(DocumentSnapshot snapShot) {
    var snap = snapShot.data() as Map<String, dynamic>;

    return Post(
      postId: snap['postId'],
      postUrl: snap['postUrl'],
      profImage: snap['profImage'],
      likes: snap['likes'],
      datePublished: snap['datePublished'],
      uid: snap['uid'],
      username: snap['username'],
      description: snap['description'],
    );
  }
}
