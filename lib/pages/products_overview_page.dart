

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';


import '../components/product_grid.dart';
import '../components/product_item.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';
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
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}

