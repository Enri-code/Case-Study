// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:case_study/domain/auth.dart';
import 'package:case_study/models/user.dart';

enum AuthState {
  LoggedOut,
//
  Registering,
  Registered,
  NotRegistered,
  //
  Authenticating,
  LoggedIn,
  NotLoggedIn,
}

class AuthProvider with ChangeNotifier {
  final _auth = FakeAuth();
  User? _user;

  User get user => _user!;

  AuthState _loggedInState = AuthState.NotLoggedIn;
  AuthState _registeredState = AuthState.NotRegistered;

  String? authError;
  bool hasError = false;

  AuthState get loggedInState => _loggedInState;
  AuthState get registeredState => _registeredState;

  set loggedInState(val) {
    _loggedInState = val;
    notifyListeners();
  }

  set registeredState(val) {
    _registeredState = val;
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    loggedInState = AuthState.Authenticating;
    try {
      var credentials = await GoogleSignIn().signIn();
      if (credentials == null) return;
      loggedInState = AuthState.LoggedIn;

      _user = User.fromMap({
        'id': credentials.id,
        'first_name': credentials.displayName,
        'email': credentials.email,
        'avatar': credentials.photoUrl,
      });
    } catch (e) {
      loggedInState = AuthState.NotLoggedIn;
      hasError = true;
    }
  }

  Future<void> login(String email, String password) async {
    loggedInState = AuthState.Authenticating;
    try {
      var userMap = await _auth.login(email, password);
      loggedInState = AuthState.LoggedIn;
      _user = User.fromMap(userMap['user']);
    } catch (e) {
      loggedInState = AuthState.NotLoggedIn;
      hasError = true;
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    registeredState = AuthState.Authenticating;
    try {
      var userMap = await _auth.register(email, password);
      registeredState = AuthState.Registered;
      _user = User.fromMap(userMap);
    } catch (e) {
      registeredState = AuthState.NotRegistered;
      hasError = true;
      rethrow;
    }
  }
}
