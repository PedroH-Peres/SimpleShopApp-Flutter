import 'package:flutter/material.dart';
import 'package:shop_app/pages/products_overview_page.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja',
      theme: ThemeData(primaryColor: Colors.blue),
      home: ProductsOverviewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}