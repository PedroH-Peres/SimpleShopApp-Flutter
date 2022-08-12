

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';


import '../components/product_grid.dart';
import '../components/product_item.dart';
import '../data/dummy_data.dart';
import '../models/product.dart';

class ProductsOverviewPage extends StatelessWidget {


  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Minha Loja")),
      ),
      body: ProductGrid(),
    );
  }
}

