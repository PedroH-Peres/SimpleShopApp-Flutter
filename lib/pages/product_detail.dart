import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
 
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name), 
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(child: Image.network(product.imageUrl, fit: BoxFit.cover,), width: double.infinity, height: 300, ),
            SizedBox(height: 10),
            Text('R\$${product.price}', style: TextStyle(color: Colors.grey, fontSize: 20),),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(product.description, textAlign: TextAlign.center,),
            )
          ],
        )
      ),
    );
  }
}