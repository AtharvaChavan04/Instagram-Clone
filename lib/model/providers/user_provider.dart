import 'package:flutter/material.dart';
import 'package:instagram_clone/model/data_models/user_model.dart';
import 'package:instagram_clone/model/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
