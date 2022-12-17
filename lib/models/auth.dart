import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:simpleshopflutter/exceptions/auth_exception.dart';

class Auth with ChangeNotifier{

  static const _url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCDeLNHyZa6sU2eLKg_SWW5zCpEktIOA7I';
  
  Future<void> _authenticate(String email, String password, String urlFragment) async{
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=AIzaSyCDeLNHyZa6sU2eLKg_SWW5zCpEktIOA7I';
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
    }
    print(body);
  }
  
  Future<void> signup(String email, String password) async{
    return _authenticate(email, password, 'signUp');
  }

  Future<void> singin(String email, String password) async{
    return _authenticate(email, password, 'signInWithPassword');
  }
}