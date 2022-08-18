import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_itemwidget.dart';

import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                  style: TextStyle(fontSize: 20, ),
                  ),
                  SizedBox(width: 20),
                  Chip(label: Text("R\$${cart.totalAmount}", style: TextStyle(color: Colors.white),),
                  backgroundColor: Theme.of(context).colorScheme.primary,),
                  Spacer(),
                  TextButton(
                    child: Text("COMPRAR"),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Theme.of(context).colorScheme.primary)
                    ),
                    onPressed: (){},
                  )
                ],
              ),
            )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) => CartItemWidget(cartItem: items[index]),
            ),
          ),
        ],
      )
    );
  }
}