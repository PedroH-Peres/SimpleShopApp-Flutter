

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/models/product_list.dart';


import '../components/badge.dart';
import '../components/product_grid.dart';
import '../components/product_grid_item.dart';
import '../data/dummy_data.dart';
import '../models/cart.dart';
import '../models/product.dart';
import '../utils/app_routes.dart';
enum FilterOptions {
  Favorite,
  All
}


class ProductsOverviewPage extends StatefulWidget {
  

  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {

  bool _showFavoriteOnly = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Minha Loja")),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Somente Favoritos'), value: FilterOptions.Favorite,),
              PopupMenuItem(child: Text('Todos'), value: FilterOptions.All,)
            ],
            onSelected: (FilterOptions selected){
              setState(() {
                if(selected == FilterOptions.Favorite){
                  _showFavoriteOnly = true;
                }else if(selected == FilterOptions.All){
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                },
                icon: Icon(Icons.shopping_cart),
              ),
            builder: (ctx, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}

