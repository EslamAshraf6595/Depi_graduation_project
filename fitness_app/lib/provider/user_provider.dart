import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserProvider extends ChangeNotifier {
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? location;
  String? city;
  String? password;

  late Box _box;

  UserProvider() {
    _box = Hive.box('userBox');
    username = _box.get('username');
    email = _box.get('email');
    firstName = _box.get('firstName');
    lastName = _box.get('lastName');
    dateOfBirth = _box.get('dateOfBirth');
    location = _box.get('location');
    city = _box.get('city');
    password = _box.get('password');
  }

  bool get isLoggedIn => username != null;

  // -------------------------------------------------------------------
  // Save user basic account info
  // -------------------------------------------------------------------
  void saveAccountInfo({
    required String username,
    required String email,
    required String password,
  }) {
    this.username = username;
    this.email = email;
    this.password = password;

    _box.put('username', username);
    _box.put('email', email);
    _box.put('password', password);

    notifyListeners();
  }

  // -------------------------------------------------------------------
  // Save biodata
  // -------------------------------------------------------------------
  void saveBiodata({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String location,
    required String city,
  }) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.dateOfBirth = dateOfBirth;
    this.location = location;
    this.city = city;

    _box.put('firstName', firstName);
    _box.put('lastName', lastName);
    _box.put('dateOfBirth', dateOfBirth);
    _box.put('location', location);
    _box.put('city', city);

    notifyListeners();
  }

  // -------------------------------------------------------------------
  // LOGIN FUNCTION  (the missing one)
  // -------------------------------------------------------------------
  Future<bool> login(String emailInput, String passwordInput) async {
    final savedEmail = _box.get('email');
    final savedPassword = _box.get('password');

    if (savedEmail == null || savedPassword == null) {
      // User not registered
      return false;
    }

    if (emailInput == savedEmail && passwordInput == savedPassword) {
      // Successful login
      email = savedEmail;
      password = savedPassword;
      username = _box.get('username');

      notifyListeners();
      return true;
    }

    return false;
  }

  // -------------------------------------------------------------------
  // LOGOUT
  // -------------------------------------------------------------------
  void logout() {
    _box.clear();
    username = null;
    
    notifyListeners();
  }
}
