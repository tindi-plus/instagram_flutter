import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  InstaUser? _user;
  AuthMethods _authMethods = AuthMethods();

  InstaUser get getUser => _user!;

  Future<void> refreshUser() async {
    InstaUser user = await _authMethods.getUserDetail();
    _user = user;
    notifyListeners();
  }
}
