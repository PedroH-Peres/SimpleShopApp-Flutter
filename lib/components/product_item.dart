import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(product.imageUrl, fit: BoxFit.cover,),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.favorite),
            onPressed: (){},
          ),
          title: Text(product.title, textAlign: TextAlign.center,),
          trailing: IconButton(
            color: Colors.white,
            icon: Icon(Icons.shopping_cart),
            onPressed: (){}, 
          ),
        ),
      ),
    );
  }
}