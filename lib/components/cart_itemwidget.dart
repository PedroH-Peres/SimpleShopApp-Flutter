import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 40,),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      confirmDismiss: (_){     
        return showDialog<bool>(context: context, 
        builder: (ctx) => AlertDialog(
          title: Text('Tem certeza?'),
          content: Text("Deseja remover o item do carrinho?"),
          actions: [
            TextButton(child: Text("Não"), onPressed: (){Navigator.of(ctx).pop(false);},),
            TextButton(child: Text("Sim"), onPressed: (){Navigator.of(ctx).pop(true);},)
          ],
        ));
      },
      onDismissed: (_){

        Provider.of<Cart>(context, listen: false).removeItem(cartItem.productId);

      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Padding(padding: EdgeInsets.all(5),
              child: FittedBox(child: Text('${cartItem.price}')),
            ),
          ),
          title: Text(cartItem.name.toString()),
          subtitle: Text('Total: R\$${cartItem.price * cartItem.quantity}'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }
}