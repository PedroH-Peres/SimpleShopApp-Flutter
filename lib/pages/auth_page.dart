import 'dart:js_util';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simpleshopflutter/components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(137, 40, 80, 0.9),
                Color.fromRGBO(50, 90, 157, 0.7)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                  transform: Matrix4.rotationZ(-8* pi /180),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepOrange.shade900,
                    boxShadow: [BoxShadow(
                      blurRadius: 8,
                      color: Colors.black,
                      offset: Offset(0, 2)
                    )]
                  ),
                  child: Text("Minha loja", style: TextStyle(fontSize: 45, fontFamily: 'Anton', color: Colors.white),),
                ),
                AuthForm(),
                Divider(),
                Text("Feito por Pedro H. Peres - Curso Cod3r")
              ],
            ),
          )
        ],
      )
    );
  }
}