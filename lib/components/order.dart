import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children:[
          ListTile(
          title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
          subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date)),
          trailing: IconButton(
            icon: Icon(Icons.expand_more),
            onPressed: (){
              setState(() {
                _expanded = !_expanded;
              });
            },
            ),
          ),
          if(_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: (widget.order.products.length *20) + 10,
              child: ListView(
                children: widget.order.products.map((product){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.name, style: TextStyle(fontWeight: FontWeight.bold),),
                      Spacer(),
                      Text('${product.quantity}x  R\$ ${product.price}'),

                    ],
                  );
                }
                ).toList()
              ),
            )
            
          
        ] 
      ),
    );
  }
}