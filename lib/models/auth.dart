import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier{

  static const _url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCDeLNHyZa6sU2eLKg_SWW5zCpEktIOA7I';
  Future<void> signup(String email, String password) async{
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      }),
    );

    print(jsonDecode(response.body));
  }

}