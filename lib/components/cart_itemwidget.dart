import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}