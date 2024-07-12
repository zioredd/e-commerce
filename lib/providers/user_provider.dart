import 'package:e_commerce_app/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    email: "",
    password: "",
    name: "",
    address: "",
    role: "",
    token: "",
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
