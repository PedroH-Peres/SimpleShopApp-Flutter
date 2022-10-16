import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(product.imageUrl, fit: BoxFit.cover,),
          onTap: (){
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder:(ctx, product, _) =>  IconButton(
              color: Colors.purple,
              icon: Icon(product.isFavorite ?Icons.favorite :Icons.favorite_border),
              onPressed: (){
                product.toggleFavorite();
              },
            ),
          ),
          title: Text(product.name, textAlign: TextAlign.center,),
          trailing: IconButton(
            color: Colors.purple,
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Produto adicionado com sucesso!"), duration: Duration(seconds: 2),
                action: SnackBarAction(label: "Desfazer", onPressed: (){cart.removeSingleProduct(product.id);},),
                )
              );
              cart.addItem(product);
            }, 
          ),
        ),
      ),
    );
  }
}