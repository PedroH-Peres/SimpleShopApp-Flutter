import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 300,
      child: Column(
        children: [
          AppBar(
            title: Text('Bem vindo usuário!'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Loja"),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Pedidos"),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS),
          )
        ],
      ),
    );
  }
}