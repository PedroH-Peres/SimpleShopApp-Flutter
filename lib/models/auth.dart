import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:simpleshopflutter/exceptions/auth_exception.dart';

import '../data/store.dart';

class Auth with ChangeNotifier{
  String? _token;
  String? _email;
  String? _userid;
  DateTime? _expiryDate;
  Timer? _logoutTimer;


  bool get isAuth{
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token{
    return isAuth ? _token : null;
  }
  
  String? get email{
    return isAuth ? _email : null;
  }

  String? get userid{
    return isAuth ? _userid : null;
  }

  static const _url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCbFEPfZGCvqlZLZFbNjl71riXD9NWH7y4';
  
  Future<void> _authenticate(String email, String password, String urlFragment) async{
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyCbFEPfZGCvqlZLZFbNjl71riXD9NWH7y4';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      })
    );

    final body = jsonDecode(response.body);
    if(body['error'] != null){

      throw AuthException(body['error']['message']);
      
    }else{
      _token = body['idToken'];
      _email = body['email'];
      _userid = body['localId'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn']))
      );
      Store.saveMap('userData', {'token': _token, 'email': _email, 'userid': _userid, 'expiryDate': _expiryDate!.toIso8601String()});

      _autoLogout();
      notifyListeners();
    }

  }
  
  Future<void> signup(String email, String password) async{
    return _authenticate(email, password, 'signUp');
  }

  Future<void> singin(String email, String password) async{
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async{
    if(isAuth) return;

    final userData = await Store.getMap('userData');
    if(userData.isEmpty) return;

    final expiryDate = DateTime.parse(userData['expiryDate']);
    if(expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _userid = userData['userid'];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
  }

  void logout(){
    _token = null;
    _userid = null;
    _email = null;
    _expiryDate = null;
    _clearLogoutTimer();
    Store.remove('userData').then((value) => notifyListeners);
  }

  void _clearLogoutTimer(){
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout(){
    _clearLogoutTimer();
    final timeToLogout = _expiryDate?.difference(DateTime.now()).inSeconds;
     _logoutTimer = Timer(Duration(seconds: timeToLogout ?? 0), logout);
  }
}