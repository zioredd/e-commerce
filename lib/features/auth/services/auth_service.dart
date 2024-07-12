// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:convert';

import 'package:e_commerce_app/constants/error.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/features/auth/models/user_model.dart';
import 'package:e_commerce_app/features/auth/screens/home_screen.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signupUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: "",
          email: email,
          password: password,
          name: name,
          address: "",
          role: "",
          token: "");

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandling(
        context: context,
        response: res,
        onSuccess: () {
          showSnackBar(
              context, 'Account created! Login with the same credentials!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signinUser({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    try {
      http.post(
        Uri.parse('$uri/api/login'),
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).then((res) {
        httpErrorHandling(
          context: context,
          response: res,
          onSuccess: () async {
            print(res.body);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (route) => false,
            );
          },
        );
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
