import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String ? _token;
  String ? _username;

  String ? get token =>_token;
  String ? get username => _username;
  bool get isAuthenticated => _token != null;

  Future<bool> login(String user, String pass) async {
    await Future.delayed(const Duration(seconds: 1));
    if (user.isNotEmpty && pass.length >= 6) {
      _token = "fake_token_123";
      _username = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _token = null;
    _username = null;
    notifyListeners();
  }
}