import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:simpleshopflutter/exceptions/http_exception.dart';

import '../models/product.dart';
import '../models/product_list.dart';
import '../utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(product.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
              onPressed: (){
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
              },
            ),
            Dismissible(
              key: ValueKey(product.id),
              child: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: (){
                  showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
                    title: Text('Excluir produto'),
                    content: Text("Tem certeza de que deseja remover o produto?"),
                    actions: [
                      TextButton(onPressed: (){Navigator.of(ctx).pop(false);}, child: Text("Não")),
                      TextButton(onPressed: (){Navigator.of(ctx).pop(true);}, child: Text("Sim"))
                    ],
                  )).then((value) async {
                    if(value ?? false){
                      try{
                        await Provider.of<ProductList>(context,listen: false).removeProduct(product);
                      }catch(error){
                        msg.showSnackBar(SnackBar(content: Text(error.toString())));
                      }
                    }
                  });
                },
                ),
              
            )
          ],
        ),
      ),
    );
  }
}