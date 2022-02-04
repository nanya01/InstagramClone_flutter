import 'package:flutter/material.dart';
import 'package:instagram_flutter/auth/auth_service.dart';
import 'package:instagram_flutter/models/user.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  final AuthService _authService = AuthService();
  Users get getUser =>
      _user ??
      const Users(
        email: '',
        uid: '',
        photoUrl: '',
        username: '',
        bio: '',
        followers: [],
        following: [],
      );

  Future<void> refreshUser() async {
    Users user = await _authService.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
