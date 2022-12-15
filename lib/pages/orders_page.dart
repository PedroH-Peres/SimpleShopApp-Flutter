import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/app_drawer.dart';
import '../components/order.dart';
import '../models/order_list.dart';


class OrdersPage extends StatelessWidget {

  Future<void> _refreshpage(BuildContext context){
    return Provider.of<OrderList>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.error != null){
            return Center(child: Text("ERRO!"),);  
          }else{
            return Consumer<OrderList>(
              builder: (ctx, orders, child) => ListView.builder(
              itemCount: orders.itemsCount,
              itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
              ),
            );
          }
        },
      ),
      /*body: RefreshIndicator(onRefresh: () => _refreshpage(context),
        child: _isLoading 
        ? const Center(child: CircularProgressIndicator(),)
        : ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
        ),
      ),*/
    );
  }
}
